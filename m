Return-Path: virtio-dev-return-2623-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A1C6B5819120
	for <virtio-dev@lists.oasis-open.org>; Tue, 24 Oct 2017 07:07:31 -0700 (PDT)
From: "Avi Cohen (A)" <avi.cohen@huawei.com>
Date: Tue, 24 Oct 2017 14:07:21 +0000
Message-ID: <B84047ECBD981D4B93EAE5A6245AA361013EF401@FRAEML521-MBX.china.huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] vhost-user to interconnect vm's
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Ofer Ben-Yacov <ofer.benyacov@toganetworks.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,
I wonder if it is possible to directly connect 2  VM's (without host interv=
ention) with  vhost-user interface , so one VM is slave and the 2nd  is the=
 master.
I can connect the VM's with OVS-DPDK (or VPP)  in the middle - but this req=
uires an extra copy.
Best Regards
Avi

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

