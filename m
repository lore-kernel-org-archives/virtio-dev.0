Return-Path: virtio-dev-return-5900-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58D7C985BB5
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Jul 2019 01:46:17 +0000 (UTC)
Date: Wed, 31 Jul 2019 09:44:21 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20190731014421.GA24385@___>
References: <20190731013446.23591-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731013446.23591-1-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH v2] content: explicitly document the VLAN filtering as
 best-effort
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 31, 2019 at 09:34:46AM +0800, Tiwei Bie wrote:
> Similar to the MAC address based filtering, the VLAN filtering
> is also best-effort in implementations, but it's not quite clear
> in the spec. So document this behaviour explicitly to reflect
> the way implementations behave.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---

Please start the vote on resolving this issue.
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/47

Thanks,
Tiwei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

