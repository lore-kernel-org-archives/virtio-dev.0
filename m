Return-Path: virtio-dev-return-2648-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DD8F71CB8098
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Nov 2017 10:02:24 -0700 (PDT)
From: "Avi Cohen (A)" <avi.cohen@huawei.com>
Date: Thu, 2 Nov 2017 13:43:29 +0000
Message-ID: <B84047ECBD981D4B93EAE5A6245AA361013EF9AC@FRAEML521-MBX.china.huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] dual NIC (not smart NIC)
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

I don't know if this is the forum to ask - but did not find an answer in th=
e data-sheets.
Question:
Can I use dual-NIC - ( not a  smartNIC)   - e.g. - Intel X540, 82599 , XL-7=
110  or Mellanox ConnectX(r) EN - Dual-Port 10GbE  as a switch ?    =20
meaning packet received on NIC 1 will be forwarded to  NIC 2,  based on e.g=
. dst-mac address ?  without sending the packet to the CPU ?
I understand that smart-NICs are able to do this and much more ..

Thank you
Avi

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

