Return-Path: virtio-dev-return-4196-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EE4A358191B9
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 May 2018 06:44:30 -0700 (PDT)
Date: Tue, 29 May 2018 15:44:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180529154415.4b0648c4.cohuck@redhat.com>
In-Reply-To: <20180524164951.3102-1-tiwei.bie@intel.com>
References: <20180524164951.3102-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v4] content: support SR-IOV
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 25 May 2018 00:49:51 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> Allocate a feature bit for virtio devices which support SR-IOV.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/11
> ---
> More details can be found from this thread:
> https://patchwork.kernel.org/patch/10285541/
> 
> v3 -> v4:
> - Limit the feature to PCI devices with SR-IOV cap (MST);
> 
> v2 -> v3:
> - Improve the wording (Cornelia);
> 
> v1 -> v2:
> - s/Reserve/Allocate/ (MST);
> - Add a Fixes tag (MST);
> - Be more explicit in driver requirement (MST);
> - Remove the "device MAY fail" description (MST);
> - Rebase on IO_BARRIER patch;
> 
> RFC -> v1:
> - Mention PCI in the description (Cornelia);
> 
>  content.tex | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

