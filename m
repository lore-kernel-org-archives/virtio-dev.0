Return-Path: virtio-dev-return-5539-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE437985DD0
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Feb 2019 14:53:34 +0000 (UTC)
Date: Wed, 27 Feb 2019 09:53:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190227094937-mutt-send-email-mst@kernel.org>
References: <JIRA.22281.1382619093000@attica.dfw01.oasis-infra.net>
 <JIRA.22281.1382619093000.8.1403756471141@attica.dfw01.oasis-infra.net>
 <20140630182221.GM14729@olila.local.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140630182221.GM14729@olila.local.net-space.pl>
Subject: [virtio-dev] Re: [virtio] [OASIS Issue Tracker] (VIRTIO-46) Verify that VIRTIO
 devices could be implemented in Xen environment
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, sstabellini@kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 30, 2014 at 08:22:21PM +0200, Daniel Kiper wrote:
> On Thu, Jun 26, 2014 at 04:21:11AM +0000, OASIS Issues Tracker wrote:
> >
> >      [ https://issues.oasis-open.org/browse/VIRTIO-46?page=com.atlassian.jira.plugin.system.issuetabpanels:all-tabpanel ]
> >
> > Rusty Russell updated VIRTIO-46:
> > --------------------------------
> >
> >     Fix Version/s: virtio 1.0 csprd03
> 
> Should not it be: Fix Version/s: virtio 2.0?
> 
> Daniel

Re: https://issues.oasis-open.org/browse/VIRTIO-46

Daniel do you still intend to work on this?

I think that mostly we just need to add a non-normative legacy section
to state that in the Xen environment virtio assumes PLATFORM_ACCESS.

Stefano would you agree?

> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that 
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

