let ExtensionHooks = {};

// NOTE: any extensions included here need to also be added to ./deps.js.sh
// NOTE: during development you may want to change 'deps' in the path to 'forks', but remember to change it back before committing!

import { GeolocateHooks } from "./../../deps/bonfire_geolocate/assets/js/extension"
import { NotifyHooks } from "./../../deps/bonfire_notify/assets/js/extension"
import LiveSelect from "./../../deps/live_select/priv/static/live_select.min.js"

Object.assign(ExtensionHooks, LiveSelect, NotifyHooks, GeolocateHooks)

export { ExtensionHooks }
