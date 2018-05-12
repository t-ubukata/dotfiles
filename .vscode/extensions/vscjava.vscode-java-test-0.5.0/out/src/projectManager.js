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
const Commands = require("./Constants/commands");
const Logger = require("./Utils/Logger/logger");
const path = require("path");
const vscode_1 = require("vscode");
class ProjectManager {
    constructor() {
        this.projectInfos = [];
    }
    refresh(token) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!vscode_1.workspace.workspaceFolders) {
                return;
            }
            return Promise.all(vscode_1.workspace.workspaceFolders.map((wkspace) => {
                return this.getProjectInfo(wkspace.uri).then((infos) => {
                    infos.forEach((i) => { i.path = vscode_1.Uri.parse(i.path.toString()); });
                    this.storeProjects(infos);
                }, (reason) => {
                    if (token.isCancellationRequested) {
                        return;
                    }
                    Logger.error(`Failed to refresh project mapping. Details: ${reason}.`);
                    return Promise.reject(reason);
                });
            }));
        });
    }
    storeProjects(infos) {
        this.projectInfos = this.projectInfos.concat(infos);
    }
    getAll() {
        return this.projectInfos.map((i) => (Object.assign({}, i)));
    }
    getProjectName(file) {
        const fpath = this.formatPath(file.fsPath);
        const matched = this.projectInfos.filter((p) => fpath.startsWith(this.formatPath(p.path.fsPath)));
        if (matched.length === 0) {
            Logger.error(`Failed to get project name for file ${file}.`);
            return undefined;
        }
        if (matched.length > 1) {
            Logger.error(`Found multiple projects for file ${file}: ${matched}`);
            return undefined;
        }
        return matched[0].name;
    }
    formatPath(p) {
        if (!p) {
            return p;
        }
        let formatted = path.normalize(p).toLowerCase().replace(/\\/g, '/');
        if (!formatted.endsWith('/')) {
            formatted += '/';
        }
        return formatted;
    }
    getProjectInfo(folder) {
        return Commands.executeJavaLanguageServerCommand(Commands.JAVA_GET_PROJECT_INFO, folder.toString());
    }
}
exports.ProjectManager = ProjectManager;
//# sourceMappingURL=projectManager.js.map