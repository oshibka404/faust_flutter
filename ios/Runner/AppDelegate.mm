#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "DSP/DspFaust.h"

@implementation AppDelegate {
    DspFaust *dspFaust;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dspFaust = new DspFaust(44100, 256); // TODO: get rid of hardcoded SR & buff size
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* synthControlChannel = [FlutterMethodChannel
        methodChannelWithName:@"faust_flutter/dsp_channel"
        binaryMessenger:controller.binaryMessenger];
    
    __weak typeof(self) weakSelf = self;
    [synthControlChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // Note: this method is invoked on the UI thread.
        if ([@"start" isEqualToString:call.method]) {
            bool success = [weakSelf start];
            result(@(success));
        } else if ([@"stop" isEqualToString:call.method]) {
            [weakSelf stop];
            result(nil);
        } else if ([@"isRunning" isEqualToString:call.method]) {
            bool isRunningResult = [weakSelf isRunning];
            result(@(isRunningResult));
        } else if ([@"getParamsCount" isEqualToString:call.method]) {
            int paramsCount = [weakSelf getParamsCount];
            result(@(paramsCount));
        } else if ([@"getParamInit" isEqualToString:call.method]) {
            NSNumber* idArg = (call.arguments[@"id"]);
            float paramInit = [weakSelf getParamInitById:idArg.intValue];
            result(@(paramInit));
        } else if ([@"getParamInitByPath" isEqualToString:call.method]) {
            NSString* pathArg = (call.arguments[@"path"]);
            float paramInit = [weakSelf getParamInitByPath:[pathArg UTF8String]];
            result(@(paramInit));
        } else if ([@"getParamValue" isEqualToString:call.method]) {
            NSNumber* idArg = call.arguments[@"id"];
            float paramValue = [weakSelf getParamValueById:idArg.intValue];
            result(@(paramValue));
        } else if ([@"getParamValueByPath" isEqualToString:call.method]) {
            NSString* pathArg = call.arguments[@"path"];
            float paramValue = [weakSelf getParamValueByPath:[pathArg UTF8String]];
            result(@(paramValue));
        } else if ([@"getParamMin" isEqualToString:call.method]) {
            NSNumber* idArg = call.arguments[@"id"];
            float paramMin = [weakSelf getParamMinById:idArg.intValue];
            result(@(paramMin));
        } else if ([@"getParamMinByPath" isEqualToString:call.method]) {
            NSString* pathArg = call.arguments[@"path"];
            float paramMin = [weakSelf getParamMinByPath:[pathArg UTF8String]];
            result(@(paramMin));
        } else if ([@"getParamMax" isEqualToString:call.method]) {
            NSNumber* idArg = call.arguments[@"id"];
            float paramMax = [weakSelf getParamMaxById:idArg.intValue];
            result(@(paramMax));
        } else if ([@"getParamMaxByPath" isEqualToString:call.method]) {
            NSString* pathArg = call.arguments[@"path"];
            float paramMax = [weakSelf getParamMaxByPath:[pathArg UTF8String]];
            result(@(paramMax));
        } else if ([@"setParamValue" isEqualToString:call.method]) {
            NSNumber* idArg = call.arguments[@"id"];
            NSNumber* valueArg = call.arguments[@"value"];
            [weakSelf setParamById:idArg.intValue Value:valueArg.floatValue];
            result(nil);
        } else if ([@"setParamValueByPath" isEqualToString:call.method]) {
            NSString* pathArg = call.arguments[@"path"];
            NSNumber* valueArg = call.arguments[@"value"];
            [weakSelf setParamByPath:[pathArg UTF8String] Value:valueArg.floatValue];
            result(nil);
        } else if ([@"keyOn" isEqualToString:call.method]) {
            NSNumber* pitchArg = call.arguments[@"pitch"];
            NSNumber* velocityArg = call.arguments[@"velocity"];
            long voiceId = [weakSelf keyOn:pitchArg.intValue WithVelocity:velocityArg.intValue];
            result(@(voiceId));
        } else if ([@"keyOff" isEqualToString:call.method]) {
            NSNumber* pitchArg = call.arguments[@"pitch"];
            int keyOffResult = [weakSelf keyOff:pitchArg.intValue];
            result(@(keyOffResult));
        } else if ([@"allNotesOff" isEqualToString:call.method]) {
            [weakSelf allNotesOff];
            result(nil);
        } else if ([@"newVoice" isEqualToString:call.method]) {
            long voiceId = [weakSelf newVoice];
            result(@(voiceId));
        } else if ([@"deleteVoice" isEqualToString:call.method]) {
            NSNumber* voiceArg = call.arguments[@"voice"];
            int deleteVoiceResult = [weakSelf deleteVoice:voiceArg.longValue];
            result(@(deleteVoiceResult));
        } else if ([@"setVoiceParamValueByPath" isEqualToString:call.method]) {
            NSNumber* voiceArg = call.arguments[@"voice"];
            NSString* pathArg = call.arguments[@"path"];
            NSNumber* valueArg = call.arguments[@"value"];
            [weakSelf setParamByPath:[pathArg UTF8String] OfVoice:voiceArg.longValue Value:valueArg.floatValue];
            result(nil);
        } else if ([@"getVoiceParamValueByPath" isEqualToString:call.method]) {
            NSNumber* voiceArg = call.arguments[@"voice"];
            NSString* pathArg = call.arguments[@"path"];
            float voiceParamValue = [weakSelf getParamByPath:[pathArg UTF8String] OfVoice:voiceArg.longValue];
            result(@(voiceParamValue));
        } else if ([@"getCPULoad" isEqualToString:call.method]) {
            float cpuLoad = [weakSelf getCpuLoad];
            result(@(cpuLoad));
        } else if ([@"getJSONUI" isEqualToString:call.method]) {
            const char * jsonUi = [weakSelf getJSONUI];
            result(@(jsonUi));
        } else if ([@"getJSONMeta" isEqualToString:call.method]) {
            const char * jsonMeta = [weakSelf getJSONMeta];
            result(@(jsonMeta));
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (bool)start {
    return dspFaust->start();
}

- (void)stop {
    dspFaust->stop();
}

- (bool)isRunning {
    return dspFaust->isRunning();
}

- (int)getParamsCount {
    return dspFaust->getParamsCount();
}

- (float)getParamInitById:(int)paramId {
    return dspFaust->getParamInit(paramId);
}

- (float)getParamInitByPath:(const char *)path {
    return dspFaust->getParamInit(path);
}

- (float)getParamValueById:(int)paramId {
    return dspFaust->getParamValue(paramId);
}

- (float)getParamValueByPath:(const char *)path {
    return dspFaust->getParamMin(path);
}

- (float)getParamMinById:(int)paramId {
    return dspFaust->getParamMin(paramId);
}

- (float)getParamMinByPath:(const char *)path {
    return dspFaust->getParamMin(path);
}

- (float)getParamMaxById:(int)paramId {
    return dspFaust->getParamMax(paramId);
}

- (float)getParamMaxByPath:(const char *)path {
    return dspFaust->getParamMax(path);
}

- (void)setParamById:(int)paramId Value:(float)value {
    dspFaust->setParamValue(paramId, value);
}

- (void)setParamByPath:(const char *)path Value:(float)value {
    dspFaust->setParamValue(path, value);
}

- (long)keyOn:(int)pitch WithVelocity:(int)velocity {
    return dspFaust->keyOn(pitch, velocity);
}

- (int)keyOff:(int)pitch {
    return dspFaust->keyOff(pitch);
}

- (void)allNotesOff {
    dspFaust->allNotesOff();
}

- (long)newVoice {
    return dspFaust->newVoice();
}

- (int)deleteVoice:(long)voice {
    return dspFaust->deleteVoice(voice);
}

- (void)setParamByPath:(const char *)param OfVoice:(long)voiceId Value:(float)value {
    dspFaust->setVoiceParamValue(param, voiceId, value);
}

- (float)getParamByPath:(const char *)param OfVoice:(long)voice {
    return dspFaust->getVoiceParamValue(param, voice);
}

- (float)getCpuLoad {
    return dspFaust->getCPULoad();
}

- (const char *)getJSONUI {
    return dspFaust->getJSONUI();
}

- (const char *)getJSONMeta {
    return dspFaust->getJSONMeta();
}

@end