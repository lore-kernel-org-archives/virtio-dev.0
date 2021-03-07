Return-Path: virtio-dev-return-8103-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E39E5985D0A
	for <virtio-dev@lists.oasis-open.org>; Sun,  7 Mar 2021 20:57:48 +0000 (UTC)
From: Peter Okelmann <okelmann@in.tum.de>
Message-ID: <ad517312-871b-0382-20ab-12b1272057d5@in.tum.de>
Date: Sun, 7 Mar 2021 21:57:44 +0100
MIME-Version: 1.0
Subject: [virtio-dev] How to register virtio MMIO device registers with KVM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

i'm looking into virtio over MMIO. How does KVM know which guest memory
region contains MMIO device registers?
As i understand KVM exits the VM with KVM_EXIT_MMIO when MMIO memory is
accessed and for that it should know where it is.

Regards,
Peter

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

