Return-Path: virtio-dev-return-4750-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A037985CA4
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Jul 2018 12:59:08 +0000 (UTC)
Date: Fri, 27 Jul 2018 14:58:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180727145859.4cbb0f5e.cohuck@redhat.com>
In-Reply-To: <1532536840-48601-1-git-send-email-sridhar.samudrala@intel.com>
References: <1532536840-48601-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3] content: Introduce VIRTIO_NET_F_STANDBY feature
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 25 Jul 2018 09:40:40 -0700
Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> device to act as a standby for another device with the same MAC address.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com

(missing closing bracket)

> ---
>  content.tex | 8 ++++++++
>  1 file changed, 8 insertions(+)

While we certainly need to add more details later, I think we should
just go ahead with this now as it at least gives some basic information
about the merged feature.

Acked-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

