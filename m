Return-Path: <mst@redhat.com>
Date: Mon, 26 Jul 2021 15:03:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during
 reset
Message-ID: <20210726141737-mutt-send-email-mst@kernel.org>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com>
 <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 26, 2021 at 02:17:08PM +0000, Srivatsa Vaddagiri wrote:
> > On Mon, Jul 26, 2021 at 01:36:56PM +0200, Cornelia Huck wrote:
> > > On Mon, Jul 26 2021, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com> wrote:
> > >
> > > >> > +indicated by a read of \field{Status} returning 0. Such a device MUST
> also
> > > >> > fail to accept
> > > >> > +FEATURES_OK bit if driver does not negotiate
> VIRTIO_F_MMIO_RESET_WAIT.
> > > >>
> > > >> So, this basically means that an older driver that does not know the new
> > > >> feature bit will not work with devices offering this bit, even if it did
> > > >> poll? This seems acceptable, I just wanted to spell it out.
> > > >
> > > > Yes I believe that's the desired result. Device has no way to know if
> driver
> > > > will poll for reset completion or not unless it accepts the feature.
> > > > Are you suggesting we explicitly put in some text in spec to that
> > > > effect?
> > >
> > > Not sure whether it is needed (do others have an opinion?), but probably
> > > not.
> >
> > What about resets before FEATURES_OK? How are these handled?
> 
> From device perspective, it's reset logic will always be same, independent of
> when reset was performed by driver (before or after feature negotiation). A
> driver that does not wait for reset completion will see undefined behavior
> after
> reset until it discovers that feature negotiation has failed?
> 
> - vatsa

Hmm. that doesn't sound too good. Makes using
feature negotiation for this kind of useless ...
Device can actually detect a read from status, right?
Maybe if it sees status was not read it can just
stay in reset state and not exit it?


> ---
> 
> Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
> non-member to the virtio-dev mailing list for consideration and inclusion.
> 
> 

