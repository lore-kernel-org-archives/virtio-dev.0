Return-Path: <virtio-comment-return-4298-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 16 Feb 2023 18:42:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230216184217-mutt-send-email-mst@kernel.org>
References: <20230216053457.414126-1-parav@nvidia.com>
 <87ttzm9gz0.fsf@redhat.com>
 <PH0PR12MB54812E87A2EE7C14D72C3FE2DCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812E87A2EE7C14D72C3FE2DCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH] changelog: Fix missing reference to driver notifications
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16, 2023 at 09:13:12PM +0000, Parav Pandit wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Thursday, February 16, 2023 3:01 AM
> > 
> > On Thu, Feb 16 2023, Parav Pandit <parav@nvidia.com> wrote:
> > 
> > > Cited commit in fixes tag missed to update the reference to drivers
> > > notifications section in past change log.
> > > Fix the reference.
> > >
> > > Fixes: be2ce1ee17e0 ("content.tex Fix Driver notifications label")
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  cl-os.tex | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Does it really make sense to patch the changelog? This is about the
> > 1.1->1.2 changes, and I'd assume it is only relevant for the released
> > 1.2 spec. We'll replace the changelog anyway when we do the 1.3 release.
> >
> Right. I got it.
> It should be fine to drop this patch.
> I took a blind scan to make sure all the previous links exists now.
> It isn't necessary from 1.2 to 1.3 as those entries will be removed as you say.

Right just post a patch to drop all of cl-os.tex.

> > [Speaking of the 1.3 release, we really should be planning for it. Maybe target
> > June or so, with a freeze in April?]
> Very good point. Yes.
> Not fully familiar yet, if its June end, may be May is alright too depending on changes in coming months.
> I am sure you and Michael are better place to make this call.



This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

