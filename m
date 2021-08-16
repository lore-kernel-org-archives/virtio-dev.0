Return-Path: <mst@redhat.com>
Date: Mon, 16 Aug 2021 01:35:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Message-ID: <20210816013138-mutt-send-email-mst@kernel.org>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com>
 <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Jason Wang <jasowang@redhat.com>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 16, 2021 at 10:09:34AM +0800, Jason Wang wrote:
> 
> 在 2021/8/11 下午6:05, Srivatsa Vaddagiri 写道:
> > * Jason Wang <jasowang@redhat.com> [2021-08-02 14:06:38]:
> > 
> > > > Maybe if it sees status was not read it can just
> > > > stay in reset state and not exit it?
> > > > 
> > > > 
> > > Or I wonder we can use increase the version instead.
> > What should be the guidance for backend/devices here? Go with version 3 only if
> > it requires driver to poll on reset? Otherwise it may break existing setups -
> > lets say Qemu is updated to report version 3 which will break older guest images
> > that understood version 2 - this is despite the same Qemu being capable of
> > serving those guests.
> 
> 
> My understanding is that qemu should stick to version 2 since it works fine.
> 
> Thanks

Yes breaking all guests does not sound like a good plan.
Which is unfortunate generally.

So thinking about all this, quite early in the setup process we
have:

        /* Figure out what features the device supports. */
        device_features = dev->config->get_features(dev);


isn't this sufficient? this will flush out
all writes and device can defer responding to reads
until reset is complete.

I know it's not elegant since there are a bunch of writes like
acknowledge and driver, but hey.

How about we just add a non-normative section explaining that trick?


> 
> > 
> > - vatsa
> > 
> > ---
> > 
> > Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
> > non-member to the virtio-dev mailing list for consideration and inclusion.
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 

