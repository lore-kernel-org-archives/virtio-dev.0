Return-Path: <virtio-dev-return-8388-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 768D7985DF2
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jul 2021 11:37:05 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
Date: Mon, 26 Jul 2021 13:36:56 +0200
Message-ID: <87eebl5msn.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain
To: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 26 2021, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com> wrote:

>> > +indicated by a read of \field{Status} returning 0. Such a device MUST also
>> > fail to accept
>> > +FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_WAIT.
>>
>> So, this basically means that an older driver that does not know the new
>> feature bit will not work with devices offering this bit, even if it did
>> poll? This seems acceptable, I just wanted to spell it out.
>
> Yes I believe that's the desired result. Device has no way to know if driver
> will poll for reset completion or not unless it accepts the feature.
> Are you suggesting we explicitly put in some text in spec to that
> effect?

Not sure whether it is needed (do others have an opinion?), but probably
not.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

