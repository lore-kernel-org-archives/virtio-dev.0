Return-Path: <virtio-comment-return-1934-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210706043334.36359-2-jasowang@redhat.com>
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-2-jasowang@redhat.com>
Date: Tue, 06 Jul 2021 14:27:58 +0200
Message-ID: <87h7h7hbjl.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH V2 1/2] virtio: introduce virtqueue state as basic facility
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:

> This patch adds new device facility to save and restore virtqueue
> state. The virtqueue state is split into two parts:
>
> - The available state: The state that is used for read the next
>   available buffer.
> - The used state: The state that is used for making buffer used.
>
> Note that, there could be devices that is required to set and get the
> requests that are being processed by the device. I leave such API to
> be device specific.
>
> This facility could be used by both migration and device diagnostic.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  content.tex | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)

> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
> +
> +If VIRTIO_F_RING_STATE has not been negotiated, a device MUST ingore
> +the read and write to the virtqueue state.
> +
> +If VIRTIO_F_RING_STATE has been negotiated:
> +\begin{itemize}
> +\item A device SHOULD ignore the write to the virtqueue state if the
> +FEATURE_OK status bit is not set.
> +\item A device SHOULD ignore the write to the virtqueue state if the
> +DRIVER_OK status bit is set.
> +\end{itemize}
> +
> +If VIRTIO_F_RING_STATE has been negotiated, a device MAY has its
> +device-specific way for the driver to set and get extra virtqueue
> +states such as in flight requests.

Maybe better

"If VIRTIO_F_RING_STATE has been negotiated, a device MAY provide a
device-specific mechanism to set and get extra virtqueue states such as
in flight reqeuests."

If a device type supports this facility, does it imply that it is always
present when VIRTIO_RING_STATE has been negotiated? I guess it could
define further device-specific features to make it more configurable.


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

