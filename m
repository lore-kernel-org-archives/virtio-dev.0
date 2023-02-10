Return-Path: <virtio-dev-return-10897-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7455F986622
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Feb 2023 11:23:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230203183532.90685-1-parav@nvidia.com>
References: <20230203183532.90685-1-parav@nvidia.com>
Date: Fri, 10 Feb 2023 12:23:14 +0100
Message-ID: <87k00p9331.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] content.tex Fix Driver notifications label
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 03 2023, Parav Pandit <parav@nvidia.com> wrote:

> Driver notifications section is under "Basic Facilities of a Virtio
> Device". However, the label is placed under "Virtqueues" section.
>
> Fix the label references.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  content.tex | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Not sure if it was originally intended to sit unter the virtqueues
section (it was lifted up one level as it disappeared under the packet
ring section), might have been.

It probably makes sense to not try and move it back into the virtqueues
section, and instead do your change. Other opinions?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

