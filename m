Return-Path: virtio-dev-return-5558-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A82D5985DF2
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Mar 2019 13:27:32 +0000 (UTC)
Date: Fri, 1 Mar 2019 08:27:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190301082448-mutt-send-email-mst@kernel.org>
References: <20190225210529-mutt-send-email-mst@kernel.org>
 <d1060c75-eaba-ab6f-ff31-38cb3a47c711@oracle.com>
 <20190227173710-mutt-send-email-mst@kernel.org>
 <c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
 <20190227184601-mutt-send-email-mst@kernel.org>
 <a617ce13-4114-469d-ef33-a1c91150eeca@oracle.com>
 <20190227193923-mutt-send-email-mst@kernel.org>
 <36901346-e3d5-4e51-6a8d-678eb5b9e352@oracle.com>
 <20190228091119-mutt-send-email-mst@kernel.org>
 <8a387954-1e21-947b-a5a9-c49adaea2e81@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a387954-1e21-947b-a5a9-c49adaea2e81@oracle.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
 PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to use
 the bypass framework)
To: si-wei liu <si-wei.liu@oracle.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev <virtio-dev@lists.oasis-open.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 28, 2019 at 05:30:56PM -0800, si-wei liu wrote:
> 
> 
> On 2/28/2019 6:26 AM, Michael S. Tsirkin wrote:
> > On Thu, Feb 28, 2019 at 01:32:12AM -0800, si-wei liu wrote:
> > > > > Will the
> > > > > change break userspace further?
> > > > > 
> > > > > -Siwei
> > > > Didn't you show userspace is already broken. You can't "further
> > > > break it", rename already fails.
> > > It's a race, userspace tends to give slave a user(space) desired name but
> > > sometimes may fail due to this race. Today if failover master is not up,
> > > rename would succeed anyway. While what you proposed prohibits user from
> > > providing a name in all circumstances if I understand you correctly. That's
> > > what I meant of breaking userspace further. On the other hand, you seem to
> > > tighten the kernel default naming to udev predictable names, which is
> > > derived from only recent systemd-udevd, while there exists many possible
> > > userspace naming schemes out of that. Users today who deliberately chooses
> > > to disable predictable naming (net.ifnames=0 biosdevname=0) and fall back to
> > > kernel provided names would expect the ethX pattern, with this change
> > > admin/user scripts which matches the ethX pattern could potentially break.
> > Whatever crashes with a name not matching ethX will crash on the
> > standby interface *anyway*.
> With udev predictable naming disabled they should not. It's not hard for
> user to look for device attribute to persistent the name well, in a
> consistent and reliable way.

Well that's special code for failover already. So far we just
taught userspace to skip renaming slave interfaces.

> > 
> > So I think what you are saying is that someone might have already
> > written scripts and gotten them to work on v4.17 when STANDBY was
> > included and these scripts rely on ethX. Now these scripts
> > will break.
> The controversial part is the new kernel naming pattern. Initially I thought
> there shouldn't be such crazy scripts relying on the pattern, but when I
> worked on cloud-init it I realized that there's already a lot of software
> taking assumption around the 'eth0' name. In the past I've seen random
> scripts that parses the ethX name assumes (incorrectly) the name ends up
> with digits, or even the digits and name are 1:1 mapped. Of course, you can
> say these are bugs in scripts themselves.

No what I say is that they will crash on rename of standby too.

> Anyway, I'll let others in the netdev to comment on this new scheme, maybe
> that's the concern of merely myself. The good part of your proposal is that
> we can get consistent slave name, which still plays its role until we move
> towards making slave names less relevant, i.e. ideally a 1-netdev model. I
> think we both agree that the master matters more than the slave names.
> > 
> > Maybe it is still early enough (just half a year passed) that the
> > number of these users would be small.  So how about a kernel config
> > option and maybe a module parameter to rename the primary?  People can
> > then opt in to the old broken behaviour.
> Were I could I would ask  why a similar opt-in (kernel config or module
> parameter) couldn't be implemented to open up the rename restriction on
> slave, net_failover in particular. What I felt about this rename restriction
> was more because of historical reason than anything else, while net_failover
> is comparatively a new type of link that we are now designing proper use
> case it should support, and can get it shaped to whatever it fits. My
> personal view is that the slave can't be renamed when master is running is
> just implementation details that got incorrectly exposed to userspace apps
> for many years. It's old behavior with historical reason for sure, but I
> don't think this applies to net_failover.
> 
> (FWIW as one previous bond maintainer for another OS, we relieved the rename
> restriction slaves 13 year ago, while no single complaint or issue was ever
> raised because of this change over the years, neither from the customers of
> tens of millions of installation base, nor the FOSS software running atop.
> Of course, Linux is different so that experience doesn't count.)
> 
> Thanks,
> -Siwei
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

