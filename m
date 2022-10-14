Return-Path: <virtio-dev-return-10015-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94E9B98659C
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Oct 2022 04:44:15 +0000 (UTC)
Date: Fri, 14 Oct 2022 10:14:08 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Message-ID: <20221014044408.GA168036@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Subject: [virtio-dev] KVM_SET_USER_MEMORY_REGION after VM has booted?
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

I have been checking in what scenario we may see KVM_SET_USER_MEMORY_REGION being
invoked to modify memory mapping (add or remove region of memory from VM)
*after* VM has booted. Memory hotplug may be one? Any other scenario?

Thanks
vatsa



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

