Return-Path: <virtio-dev-return-11022-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA26A98663C
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Feb 2023 08:01:29 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230216053457.414126-1-parav@nvidia.com>
References: <20230216053457.414126-1-parav@nvidia.com>
Date: Thu, 16 Feb 2023 09:01:23 +0100
Message-ID: <87ttzm9gz0.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] changelog: Fix missing reference to driver notifications
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16 2023, Parav Pandit <parav@nvidia.com> wrote:

> Cited commit in fixes tag missed to update the reference to drivers
> notifications section in past change log.
> Fix the reference.
>
> Fixes: be2ce1ee17e0 ("content.tex Fix Driver notifications label")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  cl-os.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Does it really make sense to patch the changelog? This is about the
1.1->1.2 changes, and I'd assume it is only relevant for the released
1.2 spec. We'll replace the changelog anyway when we do the 1.3 release.

[Speaking of the 1.3 release, we really should be planning for it. Maybe
target June or so, with a freeze in April?]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

