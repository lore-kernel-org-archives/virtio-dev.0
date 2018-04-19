Return-Path: virtio-dev-return-3867-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 190A6581819D
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Apr 2018 21:09:11 -0700 (PDT)
Date: Thu, 19 Apr 2018 07:08:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180419070752-mutt-send-email-mst@kernel.org>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-3-git-send-email-sridhar.samudrala@intel.com>
 <20180411155127.GQ2028@nanopsycho>
 <6a8c1ff5-153a-e40a-91b3-48532b8d3a38@intel.com>
 <20180418092515.GB1989@nanopsycho>
 <dd0d53f0-f5da-cb7d-f8f6-d0c8245eb3cf@intel.com>
 <20180418191315.GA1922@nanopsycho>
 <20180418222309-mutt-send-email-mst@kernel.org>
 <20180418203206.GC1922@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418203206.GC1922@nanopsycho>
Subject: [virtio-dev] Re: [RFC PATCH net-next v6 2/4] net: Introduce generic bypass module
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 18, 2018 at 10:32:06PM +0200, Jiri Pirko wrote:
> >> >> > With regards to alternate names for 'active', you suggested 'stolen', but i
> >> >> > am not too happy with it.
> >> >> > netvsc uses vf_netdev, are you OK with this? Or another option is 'passthru'
> >> >> No. The netdev could be any netdevice. It does not have to be a "VF".
> >> >> I think "stolen" is quite appropriate since it describes the modus
> >> >> operandi. The bypass master steals some netdevice according to some
> >> >> match.
> >> >> 
> >> >> But I don't insist on "stolen". Just sounds right.
> >> >
> >> >We are adding VIRTIO_NET_F_BACKUP as a new feature bit to enable this feature, So i think
> >> >'backup' name is consistent.
> >> 
> >> It perhaps makes sense from the view of virtio device. However, as I
> >> described couple of times, for master/slave device the name "backup" is
> >> highly misleading.
> >
> >virtio is the backup. You are supposed to use another
> >(typically passthrough) device, if that fails use virtio.
> >It does seem appropriate to me. If you like, we can
> >change that to "standby".  Active I don't like either. "main"?
> 
> Sounds much better, yes.

Excuse me, which of the versions are better in your eyes?


> 
> >
> >In fact would failover be better than bypass?
> 
> Also, much better.
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

