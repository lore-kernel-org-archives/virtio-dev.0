Return-Path: <virtio-comment-return-2038-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210721124530.37225-1-mgurtovoy@nvidia.com>
References: <20210721124530.37225-1-mgurtovoy@nvidia.com>
Date: Thu, 22 Jul 2021 12:20:49 +0200
Message-ID: <87sg067ipq.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH 1/1] virtio-blk: fix virtqueues accounting
Content-Type: text/plain
To: Max Gurtovoy <mgurtovoy@nvidia.com>, mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: oren@nvidia.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 21 2021, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> Virtqueue index is zero based, thus virtqueue (N-1) refers to requestqN.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

We had an issue for a similar fix for virtio-net, so do we want to use
issue+voting here as well, or would that be overkill? I'm inclined to do
this as an editorial update.


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

