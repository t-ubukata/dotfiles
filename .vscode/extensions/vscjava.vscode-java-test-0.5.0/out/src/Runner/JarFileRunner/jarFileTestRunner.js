"use strict";
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const Configs = require("../../Constants/configs");
const classPathUtility_1 = require("../../Utils/classPathUtility");
const Logger = require("../../Utils/Logger/logger");
const cp = require("child_process");
const getPort = require("get-port");
const os = require("os");
const path = require("path");
const rimraf = require("rimraf");
const vscode_1 = require("vscode");
class JarFileTestRunner {
    constructor(_javaHome, _storagePath, _classPathManager, _onDidChange) {
        this._javaHome = _javaHome;
        this._storagePath = _storagePath;
        this._classPathManager = _classPathManager;
        this._onDidChange = _onDidChange;
    }
    setup(tests, isDebugMode, config) {
        return __awaiter(this, void 0, void 0, function* () {
            const uris = tests.map((t) => vscode_1.Uri.parse(t.uri));
            const classpaths = this._classPathManager.getClassPaths(uris);
            const port = isDebugMode ? yield this.getPortWithWrapper() : undefined;
            const storageForThisRun = path.join(this._storagePath, new Date().getTime().toString());
            const runnerJarFilePath = this.runnerJarFilePath;
            if (runnerJarFilePath === null) {
                const err = 'Failed to locate test server runtime!';
                Logger.error(err);
                return Promise.reject(err);
            }
            const extendedClasspaths = [runnerJarFilePath, ...classpaths];
            const runnerClassName = this.runnerClassName;
            const classpathStr = yield this.constructClassPathStr(extendedClasspaths, storageForThisRun);
            const params = {
                tests,
                isDebugMode,
                port,
                classpathStr,
                runnerJarFilePath,
                runnerClassName,
                storagePath: storageForThisRun,
                config,
            };
            return params;
        });
    }
    run(env) {
        return __awaiter(this, void 0, void 0, function* () {
            const jarParams = env;
            if (!jarParams) {
                return Promise.reject('Illegal env type, should pass in IJarFileTestRunnerParameters!');
            }
            const command = yield this.constructCommandWithWrapper(jarParams);
            const cwd = env.config ? env.config.workingDirectory : vscode_1.workspace.getWorkspaceFolder(vscode_1.Uri.parse(env.tests[0].uri)).uri.fsPath;
            const process = cp.exec(command, { maxBuffer: Configs.CHILD_PROCESS_MAX_BUFFER_SIZE, cwd });
            return new Promise((resolve, reject) => {
                const testResultAnalyzer = this.getTestResultAnalyzer(jarParams);
                let bufferred = '';
                process.on('error', (err) => {
                    Logger.error(`Error occurred while running/debugging tests. Name: ${err.name}. Message: ${err.message}. Stack: ${err.stack}.`, {
                        stack: err.stack,
                    });
                    reject(err);
                });
                process.stderr.on('data', (data) => {
                    Logger.error(`Error occurred: ${data.toString()}`);
                });
                process.stdout.on('data', (data) => {
                    Logger.info(data.toString());
                    const toConsume = bufferred + data.toString();
                    const index = toConsume.lastIndexOf(os.EOL);
                    if (index >= 0) {
                        testResultAnalyzer.analyzeData(toConsume.substring(0, index));
                        bufferred = toConsume.substring(index + os.EOL.length);
                    }
                    else {
                        bufferred = toConsume;
                    }
                });
                process.on('close', (signal) => {
                    if (signal && signal !== 0) {
                        reject(`Runner exited with code ${signal}.`);
                    }
                    else {
                        if (bufferred.length > 0) {
                            testResultAnalyzer.analyzeData(bufferred);
                        }
                        resolve(testResultAnalyzer.feedBack());
                    }
                    rimraf(jarParams.storagePath, (err) => {
                        if (err) {
                            Logger.error(`Failed to delete storage for this run. Storage path: ${err}`, {
                                error: err,
                            });
                        }
                    });
                });
                if (jarParams.isDebugMode) {
                    const uri = vscode_1.Uri.parse(jarParams.tests[0].uri);
                    const rootDir = vscode_1.workspace.getWorkspaceFolder(vscode_1.Uri.file(uri.fsPath));
                    setTimeout(() => {
                        vscode_1.debug.startDebugging(rootDir, {
                            name: this.debugConfigName,
                            type: 'java',
                            request: 'attach',
                            hostName: 'localhost',
                            port: jarParams.port,
                            projectName: env.config ? env.config.projectName : undefined,
                        });
                    }, 500);
                }
            });
        });
    }
    postRun() {
        this._onDidChange.fire();
        return Promise.resolve();
    }
    getPortWithWrapper() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                return yield getPort();
            }
            catch (ex) {
                const message = `Failed to get free port for debugging. Details: ${ex}.`;
                vscode_1.window.showErrorMessage(message);
                Logger.error(message, {
                    error: ex,
                });
                throw ex;
            }
        });
    }
    constructClassPathStr(classpaths, storageForThisRun) {
        return __awaiter(this, void 0, void 0, function* () {
            let separator = ';';
            if (process.platform === 'darwin' || process.platform === 'linux') {
                separator = ':';
            }
            return classPathUtility_1.ClassPathUtility.getClassPathStr(classpaths, separator, storageForThisRun);
        });
    }
    constructCommandWithWrapper(params) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                return yield this.constructCommand(params);
            }
            catch (ex) {
                Logger.error(`Exception occurred while parsing params. Details: ${ex}`, {
                    error: ex,
                });
                rimraf(params.storagePath, (err) => {
                    if (err) {
                        Logger.error(`Failed to delete storage for this run. Storage path: ${err}`, {
                            error: err,
                        });
                    }
                });
                throw ex;
            }
        });
    }
}
exports.JarFileTestRunner = JarFileTestRunner;
//# sourceMappingURL=jarFileTestRunner.js.map