Return-Path: virtio-dev-return-8140-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89D6C986546
	for <virtio-dev@lists.oasis-open.org>; Sat, 24 Apr 2021 07:05:40 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210423162440-mutt-send-email-mst@kernel.org>
Date: Sat, 24 Apr 2021 09:05:37 +0200
Message-Id: <F6E12E6D-7F1C-41F1-96A1-838CD2D524CC@holtmann.org>
References: <777659BA-5535-4EEA-A0C1-C39380BF587E@holtmann.org>
 <20210423162440-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Reserve device id for Bluetooth device
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Michael,

>> I like to reserve device ID 40 for Bluetooth device. Thanks.
>>=20
>> Regards
>>=20
>> Marcel
>=20
> The easiest way to do this is by sending a patch with
> the proposed change:
> https://github.com/oasis-tcs/virtio-spec#providing-feedback
> and then request approval by creating a github issue:
> https://github.com/oasis-tcs/virtio-spec#use-of-github-issues

I would have done that, but there are actually missing ID numbers in the cu=
rrent git tree and one outstanding patch.

The conclusion was that 40 is the next free number.

Regards

Marcel


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

