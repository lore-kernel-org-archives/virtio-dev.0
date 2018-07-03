Return-Path: virtio-return-3161-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 3 Jul 2018 09:45:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180703094555.0a79b122.cohuck@redhat.com>
In-Reply-To: <20180703030130-mutt-send-email-mst@kernel.org>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
	<20180703030130-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] [PATCH v3 0/6] rework notifications terminology
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 3 Jul 2018 03:01:56 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jun 25, 2018 at 02:21:26PM +0200, Halil Pasic wrote:
> > Abstract 
> > --------
> > The terminology around notifications is currently somewhat
> > fragmented. Unify notifications terminology using available and used
> > buffer notification consistently for the virtqueue notifications.
> > Consistent use of the term configuration change notification is of
> > concern.  
> 
> OK I see there are acks already - do you want to start voting on this?

Let's do that, the less dangling series we have, the better.

> 
> 
> 
> > Changelog:
> > ---------
> > v2 -> v3:
> > * Addressed all comments from the previous round
> > * Added r-b's
> > 
> > v1 -> v2:
> > * Addressed Stefan's comments (mostly typos, grammar and inconsistencies).
> >   Thanks Stefan!
> > * Rebased onto the current master.
> > 
> > RFC -> v1:
> > * Devices and the transports PCI and MMIO were omitted.
> > Now the rework should be complete.
> > * Addressed review comments and minor changes for the first
> > three patches. 
> > 
> > Halil Pasic (6):
> >   notifications: unify notifications wording in core
> >   notifications: notifications as basic virtio facility
> >   ccw: map common notifications terminology to ccw
> >   pci: map common notifications terminology to PCI
> >   mmio: map common notifications terminology to MMIO
> >   notifications: update notifications terminology for devices
> > 
> >  cl-os.tex       |    2 +-
> >  conformance.tex |   10 ++--
> >  content.tex     |  164 +++++++++++++++++++++++++++++++++++++++++-------------
> >  packed-ring.tex |   60 +++++++++++---------
> >  split-ring.tex  |   72 ++++++++++++++----------
> >  5 files changed, 206 insertions(+), 102 deletions(-)
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org  


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

