"use strict";
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.
Object.defineProperty(exports, "__esModule", { value: true });
const protocols_1 = require("../../Models/protocols");
const Logger = require("../../Utils/Logger/logger");
const jarFileRunnerResultAnalyzer_1 = require("../JarFileRunner/jarFileRunnerResultAnalyzer");
const SUITE_START = 'testSuiteStarted';
const SUITE_FINISH = 'testSuiteFinished';
const TEST_START = 'testStarted';
const TEST_FAIL = 'testFailed';
const TEST_FINISH = 'testFinished';
class JUnitRunnerResultAnalyzer extends jarFileRunnerResultAnalyzer_1.JarFileRunnerResultAnalyzer {
    analyzeData(data) {
        const regex = /@@<([^@]*)>/gm;
        let match;
        do {
            match = regex.exec(data);
            if (match) {
                try {
                    this.analyzeDataCore(match[1]);
                }
                catch (ex) {
                    Logger.error(`Failed to analyze runner output data. Data: ${match[1]}.`, {
                        error: ex,
                    });
                }
            }
        } while (match);
    }
    feedBack() {
        const toAggregate = new Set();
        const result = [];
        this._tests.forEach((t) => {
            if (t.level === protocols_1.TestLevel.Class) {
                t.children.forEach((c) => this.processMethod(c, result));
            }
            else {
                this.processMethod(t, result);
            }
        });
        return result;
    }
    analyzeDataCore(match) {
        let res;
        const info = JSON.parse(match);
        switch (info.name) {
            case SUITE_START:
                this._suiteName = info.attributes.name;
                break;
            case SUITE_FINISH:
                this._suiteName = undefined;
                break;
            case TEST_START:
                this._testResults.set(this._suiteName + '#' + info.attributes.name, {
                    status: undefined,
                });
                break;
            case TEST_FAIL:
                res = this._testResults.get(this._suiteName + '#' + info.attributes.name);
                if (!res) {
                    return;
                }
                res.status = protocols_1.TestStatus.Fail;
                res.message = this.decodeContent(info.attributes.message);
                res.details = this.decodeContent(info.attributes.details);
                break;
            case TEST_FINISH:
                res = this._testResults.get(this._suiteName + '#' + info.attributes.name);
                if (!res) {
                    return;
                }
                if (!res.status) {
                    res.status = protocols_1.TestStatus.Pass;
                }
                res.duration = info.attributes.duration;
                break;
        }
    }
    processMethod(t, result) {
        if (!this._testResults.has(t.test)) {
            this._testResults.set(t.test, {
                status: protocols_1.TestStatus.Skipped,
            });
        }
        result.push({
            test: t.test,
            uri: t.uri,
            result: this._testResults.get(t.test),
        });
    }
    decodeContent(content) {
        if (!content) {
            return content;
        }
        return content.replace(new RegExp('&#x40;', 'gm'), '@');
    }
}
exports.JUnitRunnerResultAnalyzer = JUnitRunnerResultAnalyzer;
//# sourceMappingURL=junitRunnerResultAnalyzer.js.map