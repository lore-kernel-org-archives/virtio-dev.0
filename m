Return-Path: <mst@redhat.com>
Date: Sun, 15 May 2022 10:38:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 7/7] RFC: add initial support for configuring feature
 bits
Message-ID: <20220515103717-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-8-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220426225824.5918-8-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 27, 2022 at 01:58:24AM +0300, Max Gurtovoy wrote:
> After adding the concept of a management and a managed device, add
> another example of using this concept to manage resources.
> 
> Today there is no standard definition in the spec that allows user to
> setup specific feature bits of a virtio device.
> 
> For that, extend the management mechanism to allow management devices to
> change feature bits of its managed devices.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>


Please, add more explanation here. E.g. I am guessing these are
host feature bits, right? How does driver know which features are
ok to enable?

I would expect some description sections and conformance sections.


> ---
>  admin.tex | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/admin.tex b/admin.tex
> index 5b54743..43106ba 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -113,7 +113,9 @@ \subsection{VIRTIO ADMIN DEVICE CAPS IDENTIFY command}\label{sec:Basic Facilitie
>          * Bit 0 - if set, the device is a management device
>          * Bit 1 - if set, the device is a type 1 management device that supports
>          *         MSI-X vector mgmt of its type 1 managed devices
> -        * Bits 2 - 63 - reserved for future capabilities.
> +        * Bit 2 - if set, the device is a type 1 management device that supports
> +        *         feature mgmt of bits 0 to 63 for its type 1 managed devices
> +        * Bits 3 - 63 - reserved for future capabilities.
>          */
>         le64 device_admin_caps;
>         u8 reserved[112];
> @@ -143,7 +145,9 @@ \subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT command}\label{sec:Basic Facilities
>          * Bit 0 - if set, the driver accepted the device as a management device
>          * Bit 1 - if set, the driver accepted the device as a type 1 management device
>          *         that supports MSI-X vector mgmt of its type 1 managed devices
> -        * Bits 2 - 63 - reserved for future capabilities.
> +        * Bit 2 - if set, the driver accepted the device as a type 1 management device
> +        *         that supports feature mgmt of bits 0 to 63 for its type 1 managed devices
> +        * Bits 3 - 63 - reserved for future capabilities.
>          */
>         le64 driver_admin_caps;
>         u8 reserved[112];
> @@ -167,12 +171,14 @@ \subsection{VIRTIO ADMIN DEVICE MGMT command}\label{sec:Basic Facilities of a Vi
>          u8 operation;
>          /*
>           * 0 - MSI-X vector
> -         * 1 - 65535 are reserved
> +         * 1 - Device feature bits 0 to 63
> +         * 2 - 65535 are reserved
>           */
>          le16 resource;
>          /*
>           * The value to the given resource:
>           * if resource = 0 (MSI-X vector), it's a 1-based count.
> +         * if resource = 1 (Device feature bits 0 to 63), it's a feature bitmap.
>           */
>          le64 resource_val;
>          u8 reserved[5];
> -- 
> 2.21.0

