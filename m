Return-Path: virtio-dev-return-5550-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 770BD985DD1
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Feb 2019 00:38:38 +0000 (UTC)
Date: Wed, 27 Feb 2019 19:38:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190227193330-mutt-send-email-mst@kernel.org>
References: <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
 <d9ef40a2-237b-0cce-4401-ecaeac4c602a@oracle.com>
 <20190222100753-mutt-send-email-mst@kernel.org>
 <e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
 <20190225210529-mutt-send-email-mst@kernel.org>
 <d1060c75-eaba-ab6f-ff31-38cb3a47c711@oracle.com>
 <20190227173710-mutt-send-email-mst@kernel.org>
 <c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
 <20190227184601-mutt-send-email-mst@kernel.org>
 <20190227160342.788dc2b4@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227160342.788dc2b4@shemminger-XPS-13-9360>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
 PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to use
 the bypass framework)
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: si-wei liu <si-wei.liu@oracle.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev <virtio-dev@lists.oasis-open.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 27, 2019 at 04:03:42PM -0800, Stephen Hemminger wrote:
> > With this approach kernel will deny attempts by userspace to rename
> > slaves.  Slaves will always be named XXXnsby and XXnpry. Master renames
> > will rename both slaves.
> > 
> > It seems pretty solid to me, the only issue is that in theory userspace
> > can use a name like XXXnsby for something else. But this seems unlikely.
> 
> Similar schemes (with kernel providing naming) were also previously rejected
> upstream.

Links?
I'm inclined to try and see what happens.

> It has been a consistent theme that the kernel should not be in
> the renaming business.

In this case it's not in renaming business per se. The only reason
we even have the original name is due to the ways internal APIs
work. You can look at it as simply having slaves names being
part of master.

> It will certainly break userspace.

That's a strong claim. What is it based on?  It so happens that
userspace renaming slaves is already broken on virtio. So we can fix it
any way we like :)

And yes it won't help netvsc because netvsc wants compatibility with old
scripts but then netvsc uses a 2 device model anyway.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

