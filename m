Return-Path: <mst@redhat.com>
Date: Mon, 26 Jul 2021 09:19:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during
 reset
Message-ID: <20210726091851-mutt-send-email-mst@kernel.org>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87eebl5msn.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 26, 2021 at 01:36:56PM +0200, Cornelia Huck wrote:
> On Mon, Jul 26 2021, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com> wrote:
> 
> >> > +indicated by a read of \field{Status} returning 0. Such a device MUST also
> >> > fail to accept
> >> > +FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_WAIT.
> >>
> >> So, this basically means that an older driver that does not know the new
> >> feature bit will not work with devices offering this bit, even if it did
> >> poll? This seems acceptable, I just wanted to spell it out.
> >
> > Yes I believe that's the desired result. Device has no way to know if driver
> > will poll for reset completion or not unless it accepts the feature.
> > Are you suggesting we explicitly put in some text in spec to that
> > effect?
> 
> Not sure whether it is needed (do others have an opinion?), but probably
> not.

What about resets before FEATURES_OK? How are these handled?

-- 
MST

