Return-Path: virtio-dev-return-4801-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9914E985C1C
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Aug 2018 08:40:41 +0000 (UTC)
Date: Mon, 27 Aug 2018 10:40:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180827104035.4f9cf9ed.cohuck@redhat.com>
In-Reply-To: <1534358955-35869-1-git-send-email-sridhar.samudrala@intel.com>
References: <1534358955-35869-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY feature
To: Sridhar Samudrala <sridhar.samudrala@intel.com>, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 15 Aug 2018 11:49:15 -0700
Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> device to act as a standby for another device with the same MAC address.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/18

I think you need to update the github issue to point to this (v4) patch.

> ---
>  content.tex | 8 ++++++++
>  1 file changed, 8 insertions(+)

Other than that, I'd vote (...) to start voting on this issue, but
AFAIK I can't do that. Michael?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

