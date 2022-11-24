Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20221123210706.21476-1-mst@redhat.com> <20221123210706.21476-2-mst@redhat.com>
In-Reply-To: <20221123210706.21476-2-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Nov 2022 12:33:52 +0800
Message-ID: <CACGkMEtk6YLic7zjDj-yd36piLSjx5h18eXYs4rKD=uKdqprzw@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] virtio: document forward compatibility guarantees
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Feature negotiation forms the basis of forward compatibility
> guarantees of virtio but has never been properly documented.
> Do it now.
>
> Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 3051399..e3203be 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>  In particular, new fields in the device configuration space are
>  indicated by offering a new feature bit.
>
> +To keep te feature negotiation mechanism extensible, it is important
> +that devices \em{do not} offer any feature bits that they would not be
> +able to handle if the driver accepted them (even though drivers are not
> +supposed to accept them in the first place even if offered, according to
> +this version of the specification.)

It looks to me if we want to clarify like this, feature negotiation is
not sufficient. Do we need to do something similar in other basic
facilities? Generally, we probably need to do this for facilities that
are similar to features (status, virtqueue size and others).

> Likewise, it is important that
> +drivers \em{do not} accept feature bits they do not know how to handle
> +(even though devices are not supposed to offer them in the first place,
> +according to this version of the specification.) The preferred way for
> +handling reserved and unexpected features is that the driver ignores
> +them.

I'm not sure this is the best way or whether we've defined the
"unexpected features" before. It might be better to say that to accept
the features that the driver understands.

> +
> +In particular, this is
> +especially important for features limited to specific transports,
> +as enabling these for more transports in future versions of the
> +specification is highly likely to require changing the behaviour
> +from drivers and devices.  Drivers and devices supporting
> +multiple transports need to carefully maintain per-transport
> +lists of allowed features.
> +
>  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
>  The driver MUST NOT accept a feature which the device did not offer,
>  and MUST NOT accept a feature which requires another feature which was
>  not accepted.
>
> +The driver MUST validate the feature bits offered by the device.
> +The driver MUST ignore and MUST NOT accept any feature bit that is
> +\begin{itemize}
> +\item not described in this specification,
> +\item marked as reserved,
> +\item not supported for the specific transport,
> +\item not defined for the device type.
> +\end{itemize}

Do we need a similar part for the device?

> +
>  The driver SHOULD go into backwards compatibility mode
>  if the device does not offer a feature it understands, otherwise MUST
>  set the FAILED \field{device status} bit and cease initialization.
>
> +By contrast, the driver MUST NOT fail solely because a feature
> +it does not understand has been offered by the device.
> +
>  \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
>  The device MUST NOT offer a feature which requires another feature
>  which was not offered.  The device SHOULD accept any valid subset
>  of features the driver accepts, otherwise it MUST fail to set the
>  FEATURES_OK \field{device status} bit when the driver writes it.
>
> +The device MUST NOT offer feature bits corresponding to features
> +it would not support if accepted by the driver (even if the
> +driver is prohibited from accepting the feature bits by the
> +specification); for the sake of clarity, this refers to feature
> +bits not described in this specification, reserved feature bits
> +and feature bits reserved or not supported for the specific
> +transport or the specific device type, but this does not preclude
> +devices written to a future version of this specification from
> +offering such feature bits should such a specification have a
> +provision for devices to support the corresponding features.
> +
>  If a device has successfully negotiated a set of features
>  at least once (by accepting the FEATURES_OK \field{device
>  status} bit during device initialization), then it SHOULD

This sentence is incomplete.

Thanks

> --
> MST
>

