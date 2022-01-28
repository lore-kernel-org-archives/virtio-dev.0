Return-Path: <virtio-comment-return-2662-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220124093918.34371-2-mgurtovoy@nvidia.com>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com>
Date: Fri, 28 Jan 2022 13:14:14 +0100
Message-ID: <87wnikys4p.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Type: text/plain
To: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, mst@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 24 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> In one of the many use cases a user wants to manipulate features and
> configuration of the virtio devices regardless of the device type
> (net/block/console). Some of this configuration is generic enough. i.e
> Number of MSI-X vectors of a virtio PCI VF device. There is a need to do
> such features query and manipulation by its parent PCI PF.
>
> Currently virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
>
> To support this requirement in elegant way, this patch introduces a new
> admin virtqueue. Admin virtqueue will use the same command format for all
> types of virtio devices.
>
> Manipulate features via admin virtqueue is asynchronous, scalable, easy
> to extend and doesn't require additional and expensive on-die resources
> to be allocated for every new feature that will be added in the future.
>
> Subsequent patches make use of this admin virtqueue.
>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  admin-virtq.tex | 89 +++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex     |  9 +++--
>  2 files changed, 96 insertions(+), 2 deletions(-)
>  create mode 100644 admin-virtq.tex
>
> diff --git a/admin-virtq.tex b/admin-virtq.tex
> new file mode 100644
> index 0000000..1a41c22
> --- /dev/null
> +++ b/admin-virtq.tex
> @@ -0,0 +1,89 @@
> +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
> +
> +Admin virtqueue is used to send administrative commands to manipulate
> +various features of the device and/or to manipulate various features,
> +if possible, of another device within the same group (e.g. PCI VFs of
> +a parent PCI PF device are grouped together. These devices can be
> +optionally managed by its parent PCI PF using its admin virtqueue.).
> +
> +Use of Admin virtqueue is negotiated by the VIRTIO_F_ADMIN_VQ
> +feature bit.
> +
> +Admin virtqueue index may vary among different device types.

So, my understanding is:
- any device type may or may not support the admin vq
- if the device type wants to be able to accommodate the admin vq, it
  also needs to specify where it shows up when the feature is negotiated

Do we expect that eventually all device types will need to support the
admin vq (if some use case comes along that will require all devices to
participate, for example?)

Anyway, I'd reword the two sentences above:

"An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ is
negotiated. The index of the admin virtqueue is device type specific."

(...)

> @@ -6847,6 +6849,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    that the driver can reset a queue individually.
>    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>  
> +  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that
> +  the device supports administration virtqueue negotiation.

Maybe

"This feature indicates that an administration virtqueue is supported." ?

> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}


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

