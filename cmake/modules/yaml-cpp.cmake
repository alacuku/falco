# SPDX-License-Identifier: Apache-2.0
#
# Copyright (C) 2023 The Falco Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations under
# the License.
#

option(USE_BUNDLED_YAMLCPP "Enable building of the bundled yamlcpp" ${USE_BUNDLED_DEPS})

if(USE_BUNDLED_YAMLCPP)
	include(FetchContent)
	FetchContent_Declare(
		yamlcpp
		URL https://github.com/jbeder/yaml-cpp/archive/c2bec4c755c67ad86185a2a264996137904fb712.tar.gz
		URL_HASH SHA256=faea1ffdbad81b958b3b45a63ba667f4db53a3fffb983ca5df4745cf90044797
	)
	FetchContent_MakeAvailable(yamlcpp)
else()
	find_package(yaml-cpp CONFIG REQUIRED)
endif()
