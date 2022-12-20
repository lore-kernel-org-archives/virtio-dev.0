Return-Path: <virtio-dev-return-10333-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E86A59863FE
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Dec 2022 14:51:15 +0000 (UTC)
From: Marcel Holtmann <marcel@holtmann.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Message-Id: <809854E1-BB69-4639-8B53-C33E88C78E85@holtmann.org>
Date: Tue, 20 Dec 2022 15:51:13 +0100
Subject: [virtio-dev] Correct way to specify virtio_foo_config structures?
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

what is the correct way for a VIRTIO_F_VERSION_1 modern device to specify t=
he
virtio_foo_config structure. Should I make it __attribute__((packed))? What=
 field
types should be used. Everything __virtio{16,32} or better __le{16,32}? Can=
 we
have __u8 and do they have to 16-bit or 32-bit aligned.

When looking at the various examples, I see multiple combinations. What is =
the
prefered virtio_cread accessor method to be used. For example the virtio_cr=
ead_le
states something like =E2=80=9Cmodern=E2=80=9D in his comment. So the prefe=
rence is to specify
the virtio_foo_config in little-endian?

Any insights are appreciated.

Regards

Marcel


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

