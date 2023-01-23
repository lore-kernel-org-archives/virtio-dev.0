Return-Path: <virtio-comment-return-3899-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230123011651.804147-1-parav@nvidia.com>
References: <20230123011651.804147-1-parav@nvidia.com>
Date: Mon, 23 Jan 2023 12:49:14 +0100
Message-ID: <87cz75cvyd.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH] virtio-net: Improve control vq introductory description
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 23 2023, Parav Pandit <parav@nvidia.com> wrote:

> The control VQ of the virtio network device is used for controlling
> multiple features, not just advanced steering control. The control VQ
> dynamically changes multiple features of the initialized device.
>
> Hence, update this area of control VQ introductory description.
>
> This patch is on top of [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00272.html

[Side note: better put notes like that beneath the "---" delimiter, so
that they don't end up in the changelog, where they won't be of much
interest anymore.]

>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/net/description.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 41ae7f5..56bd672 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -8,7 +8,7 @@ \section{Network Device}\label{sec:Device Types / Network Device}
>  device. Empty buffers are placed in one virtqueue for receiving
>  packets, and outgoing packets are enqueued into another for
>  transmission in that order. A third command queue is used to
> -control advanced filtering features.
> +dynamically manipulate various features of the initialized device.

I think that whole paragraph needs some editing; apart from your
card/device terminology change, it hasn't seem updates in ages.

- the "most complex device supported so far" half sentence, while not
  untrue, doesn't really add much to the understanding of what the net
  device does
- same for the "It has enhanced rapidly..." statement
- more importantly, it still talks about single receive/transmit queues,
  while multiqueue has been specified for ages; this also makes the "A
  third command queue" statement a bit confusing

What about generalizing this change to a "virtio-net: Improve
introductory description" update to something like the following,
copying the purpose of the control queue from the description further
below:

"The virtio network device is a virtual ethernet device with a complex
and configurable set of features. One or more pairs of virtqueues are
used for receiving and transmitting packets: Empty buffers are placed
in the first virtqueue of the pair for receiving packets, and outgoing
packets are enqueued into the other for transmission. An optional
command queue is used to dynamically manipulate various features of the
initialized device which would not easily map into the configuration
space."


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

