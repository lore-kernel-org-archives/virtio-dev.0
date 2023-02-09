Return-Path: <virtio-comment-return-4114-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-2-mst@redhat.com>
From: David Edmondson <david.edmondson@oracle.com>
Date: Thu, 09 Feb 2023 14:52:21 +0000
In-reply-to: <20230209121221.15118-2-mst@redhat.com>
Message-ID: <m24jru3my1.fsf@oracle.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v10 01/10] virtio: document forward
 compatibility guarantees
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On Thursday, 2023-02-09 at 07:13:32 -05, Michael S. Tsirkin wrote:
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
> index 0e474dd..0c2d917 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>  In particular, new fields in the device configuration space are
>  indicated by offering a new feature bit.
>  
> +To keep the feature negotiation mechanism extensible, it is important
> +that devices \em{do not} offer any feature bits that they would not be
> +able to handle if the driver accepted them (even though drivers are not
> +supposed to accept them in the first place even if offered, according to
> +this version of the specification.) Likewise, it is important that
> +drivers \em{do not} accept feature bits they do not know how to handle
> +(even though devices are not supposed to offer them in the first place,
> +according to this version of the specification.) The preferred way for
> +handling reserved and unexpected features is that the driver ignores
> +them.
> +
> +In particular, this is
> +especially important for features limited to specific transports,
> +as enabling these for more transports in future versions of the
> +specification is highly likely to require changing the behaviour
> +from drivers and devices.  Drivers and devices supporting

"changing the behaviour of" or "changed behaviour from" (prefer the
former).

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

What does "supported" mean here? By the driver? By the specification in
respect of this transport?

> +\item not defined for the device type.
> +\end{itemize}
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
-- 
Maybe then I'll fade away and not have to face the facts.

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

