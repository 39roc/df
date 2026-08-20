# Android SDK (adb, sdkmanager, emulator)
# SDK가 없는 머신에서는 아무것도 설정하지 않는다.

for sdk in "$HOME/Library/Android/sdk" "$HOME/Android/Sdk"; do
	if [[ -d "$sdk" ]]; then
		export ANDROID_HOME="$sdk"
		export ANDROID_SDK_ROOT="$sdk"
		break
	fi
done
unset sdk

if [[ -n "$ANDROID_HOME" ]]; then
	for dir in \
		"$ANDROID_HOME/platform-tools" \
		"$ANDROID_HOME/emulator" \
		"$ANDROID_HOME/cmdline-tools/latest/bin"; do
		[[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]] && export PATH="$PATH:$dir"
	done
	unset dir
fi
