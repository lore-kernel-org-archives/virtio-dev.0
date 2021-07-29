Return-Path: <virtio-dev-return-8441-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0779986476
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jul 2021 15:21:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <BY5PR02MB70731E359EB50CD2E3827239F9E99@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com>
 <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <BY5PR02MB70731E359EB50CD2E3827239F9E99@BY5PR02MB7073.namprd02.prod.outlook.com>
Date: Thu, 29 Jul 2021 17:21:46 +0200
Message-ID: <875ywt2lit.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 27 2021, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com> wrote:

>> > > What about resets before FEATURES_OK? How are these handled?
>> >
>> > From device perspective, it's reset logic will always be same, indepen=
dent of
>> > when reset was performed by driver (before or after feature negotiatio=
n). A
>> > driver that does not wait for reset completion will see undefined beha=
vior
>> > after
>> > reset until it discovers that feature negotiation has failed?
>>
>> Hmm. that doesn't sound too good. Makes using
>> feature negotiation for this kind of useless ...
>> Device can actually detect a read from status, right?
>> Maybe if it sees status was not read it can just
>> stay in reset state and not exit it?
>
> Thinking on those lines, I am wondering if we can avoid the feature bit
> all together based on that logic.
>
> 1) Driver writes 0 to status register - device initiates reset sequence
> 2) Driver reads status - return 0x40 (VIRTIO_CONFIG_S_NEEDS_RESET)
>    if reset sequence is in progress, otherwise return 0

I don't think we can have the device return NEEDS_RESET in that case;
that status is supposed to indicate "that the device has experienced an
error from which it can=E2=80=99t recover" -- which is not the case here,
especially since the driver has already initiated a reset.

> 3) Driver writes status (ACKNOWLEDGE Bit) - if this happened before reset
>    sequence completed and before we returned 0 for status read, then reje=
ct
>    further initialization by setting VIRTIO_CONFIG_S_NEEDS_RESET (until n=
ext
>    reset that is)
>
> This should let device detect if we have a driver polling on reset comple=
tion or
> not?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

