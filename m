Return-Path: <virtio-dev-return-10017-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3232D986696
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Oct 2022 12:31:04 +0000 (UTC)
MIME-Version: 1.0
References: <20221014044408.GA168036@quicinc.com>
In-Reply-To: <20221014044408.GA168036@quicinc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Oct 2022 14:30:50 +0200
Message-ID: <CABgObfa91Xo=ZkV4wYCrJ2HTkHV7ZrwYJLi+VRcpa-EEAWJVuw@mail.gmail.com>
Subject: Re: [virtio-dev] KVM_SET_USER_MEMORY_REGION after VM has booted?
Content-Type: text/plain; charset="UTF-8"
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 14, 2022 at 6:44 AM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
> I have been checking in what scenario we may see KVM_SET_USER_MEMORY_REGION being
> invoked to modify memory mapping (add or remove region of memory from VM)
> *after* VM has booted. Memory hotplug may be one? Any other scenario?

Turning ROM BARs on and off, and PCI hotplug of passthrough devices
(because BARs are backed by host physical addresses).

Paolo


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

