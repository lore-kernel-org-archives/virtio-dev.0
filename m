Return-Path: <virtio-dev-return-8395-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC8A1985EAD
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jul 2021 14:09:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210726091851-mutt-send-email-mst@kernel.org>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com>
 <20210726091851-mutt-send-email-mst@kernel.org>
Date: Mon, 26 Jul 2021 16:09:08 +0200
Message-ID: <87bl6p5fqz.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 26 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 26, 2021 at 01:36:56PM +0200, Cornelia Huck wrote:
>> On Mon, Jul 26 2021, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com> wrote:
>> 
>> >> > +indicated by a read of \field{Status} returning 0. Such a device MUST also
>> >> > fail to accept
>> >> > +FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_WAIT.
>> >>
>> >> So, this basically means that an older driver that does not know the new
>> >> feature bit will not work with devices offering this bit, even if it did
>> >> poll? This seems acceptable, I just wanted to spell it out.
>> >
>> > Yes I believe that's the desired result. Device has no way to know if driver
>> > will poll for reset completion or not unless it accepts the feature.
>> > Are you suggesting we explicitly put in some text in spec to that
>> > effect?
>> 
>> Not sure whether it is needed (do others have an opinion?), but probably
>> not.
>
> What about resets before FEATURES_OK? How are these handled?

I'd say that neither driver nor device can assume anything. I.e. if the
driver writes 0 to status, it won't know whether it should poll or not
(polling would be the safe bet), and the device simply cannot know
whether the driver will wait with the next operation or continue
immediately.

Do we want to spell that out?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

