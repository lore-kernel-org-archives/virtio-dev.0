Return-Path: andriy.shevchenko@linux.intel.com
Date: Wed, 25 Nov 2020 14:52:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5] virtio-i2c: add the device specification
Message-ID: <20201125125238.GT4077@smile.fi.intel.com>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
MIME-Version: 1.0
In-Reply-To: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 25, 2020 at 01:55:18PM +0800, Jie Deng wrote:
> virtio-i2c is a virtual I2C adapter device. It provides a way
> to ﬂexibly communicate with the host I2C slave devices from
> the guest.
> 
> This patch adds the specification for this device.

> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/88

Hmm... Is it used like this here, in this tree?
I would rather expect BugLink:.

> Signed-off-by: Jie Deng <jie.deng@intel.com>

...

> +virtio-i2c is a virtual I2C adapter device. It provides a way to flexibly
> +organize and use the host I2C slave devices from the guest. By attaching
> +the host ACPI I2C slave nodes to the virtual I2C adapter device, the guest can
> +communicate with them without changing or adding extra drivers for these
> +slave I2C devices. 

Trailing white space.

-- 
With Best Regards,
Andy Shevchenko


