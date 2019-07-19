Return-Path: virtio-dev-return-5868-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD11D985EE3
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Jul 2019 10:23:35 +0000 (UTC)
Date: Fri, 19 Jul 2019 12:23:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190719122316.785f90e5.cohuck@redhat.com>
In-Reply-To: <20190717070916.16196-1-pagupta@redhat.com>
References: <20190717070916.16196-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3] add virtio-pmem device specification
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, mst@redhat.com, lcapitulino@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 17 Jul 2019 12:39:16 +0530
Pankaj Gupta <pagupta@redhat.com> wrote:

> This patch proposes a virtio specification for new
> virtio pmem device. Virtio pmem is a paravirtualized
> device which solves two problems:
> 
> - Provides emulation of persistent memory on host regular
>   (non NVDIMM) storage.
> - Allows the guest to bypass the page cache.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
> This is changed version from previous v2 [1], as per suggestions by
> cornelia. Incorporated v2 changes suggested by Stefan, Michael &
> Cornerlia in RFC[2].
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/201907/msg00007.html
> [2] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
> 
>  conformance.tex |  22 ++++++++++--
>  content.tex     |   1 +
>  virtio-pmem.tex | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+), 2 deletions(-)
>  create mode 100644 virtio-pmem.tex
> 

This looks good from my perspective now; but review from someone more
familiar with pmem per se would be good as well.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

