Return-Path: virtio-dev-return-5552-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95DA0985DD1
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Feb 2019 01:26:07 +0000 (UTC)
Date: Wed, 27 Feb 2019 20:26:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190227201857-mutt-send-email-mst@kernel.org>
References: <20190222100753-mutt-send-email-mst@kernel.org>
 <e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
 <20190225210529-mutt-send-email-mst@kernel.org>
 <d1060c75-eaba-ab6f-ff31-38cb3a47c711@oracle.com>
 <20190227173710-mutt-send-email-mst@kernel.org>
 <c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
 <20190227184601-mutt-send-email-mst@kernel.org>
 <a617ce13-4114-469d-ef33-a1c91150eeca@oracle.com>
 <20190227193923-mutt-send-email-mst@kernel.org>
 <20190227165205.307ed83c@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227165205.307ed83c@cakuba.netronome.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
 PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to use
 the bypass framework)
To: Jakub Kicinski <kubakici@wp.pl>
Cc: si-wei liu <si-wei.liu@oracle.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev <virtio-dev@lists.oasis-open.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 27, 2019 at 04:52:05PM -0800, Jakub Kicinski wrote:
> On Wed, 27 Feb 2019 19:41:32 -0500, Michael S. Tsirkin wrote:
> > > As this scheme adds much complexity to the kernel naming convention
> > > (currently it's just ethX names) that no userspace can understand.  
> > 
> > Anything that pokes at slaves needs to be specially designed anyway.
> > Naming seems like a minor issue.
> 
> Can the users who care about the naming put net_failover into
> "user space will do the bond enslavement" mode, and do the bond
> creation/management themselves from user space (in systemd/ 
> Network Manager) based on the failover flag?

Putting issues of compatibility aside (userspace tends to be confused if
you give it two devices with same MAC), how would you have it work in
practice? Timer based hacks like netvsc where if userspace didn't
respond within X seconds we assume it won't and do everything ourselves?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

