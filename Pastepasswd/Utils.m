// Utils.m
//
// Copyright (c) 2014 Pastepasswd (http://pastepasswd.spirosgerokostas.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "Utils.h"

@implementation Utils

+ (NSString *)randomizeStringWith:(NSString *)value {
    NSString *selectedSet = value;
    NSString *result;
    NSUInteger strLength = [selectedSet length];
    unichar *buffer = calloc(strLength, sizeof(unichar));
    [selectedSet getCharacters:buffer range:NSMakeRange(0, strLength)];
    
    for (int i = (uint32_t)strLength - 1; i >= 0; i--) {
        int j = arc4random() % (i + 1);
        unichar c = buffer[i];
        buffer[i] = buffer[j];
        buffer[j] = c;
    }
    
    result = [NSString stringWithCharacters:buffer length:strLength];
    free(buffer);
    
    return result;
}

@end
