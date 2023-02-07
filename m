Return-Path: <virtio-comment-return-3979-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230202040012.103782-1-parav@nvidia.com>
References: <20230202040012.103782-1-parav@nvidia.com>
Date: Tue, 07 Feb 2023 11:07:18 +0100
Message-ID: <87cz6lu6uh.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v2] virtio-net: Improve introductory description
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 02 2023, Parav Pandit <parav@nvidia.com> wrote:

> The control VQ of the virtio network device is used beyond advance
> steering control. The control VQ dynamically changes multiple features
> of the initialized device.
>
> Hence, update this area of control VQ introductory description at few
> places and also place the link to its description.
>
> Also update the introduction section to better describe receive and
> transmit virtqueues.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/net/description.tex | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 88a5770..dedd6b1 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -2,13 +2,13 @@ \section{Network Device}\label{sec:Device Types / Network Device}
>  
>  The virtio network device is a virtual network interface controller.
>  It consists of a virtual Ethernet link which connects the device
> -to the Ethernet network. It is the most complex of the devices
> -supported so far by virtio. It has enhanced rapidly and demonstrates
> -clearly how support for new features are added to an existing
> -device. Empty buffers are placed in one virtqueue for receiving
> -packets, and outgoing packets are enqueued into another for
> -transmission in that order. A third command queue is used to
> -control advanced filtering features.
> +to the Ethernet network. The driver posts empty buffers in the
> +receive virtqueue. The device receives the incoming packets from the link;
> +the device places these incoming packets in the receive virtqueue buffers.
> +The driver enqueues outgoing packets to the transmit virtqueue. The device
> +dequeues these packets from the transmit virtqueue and sends them to
> +the link. A control virtqueue is used to dynamically manipulate various
> +features of the initialized device.

General question: Is it better to talk about "the receive virtqueue" (to
keep it simple), or "a receive virtqueue" (as there may be several)?


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

