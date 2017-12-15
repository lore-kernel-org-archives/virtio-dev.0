Return-Path: virtio-dev-return-2833-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 059E35818F4D
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Dec 2017 02:31:42 -0800 (PST)
Message-ID: <5A33A509.1000105@intel.com>
Date: Fri, 15 Dec 2017 18:33:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171207213420-mutt-send-email-mst@kernel.org> <5A2A347B.9070006@intel.com> <CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com> <286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com> <20171211111147.GF13593@stefanha-x1.localdomain> <286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com> <20171212101440.GB6985@stefanha-x1.localdomain> <5A30E0C1.3070905@intel.com> <20171213123521.GL16782@stefanha-x1.localdomain> <5A3211CC.60607@intel.com> <20171214180449.GU14433@stefanha-x1.localdomain>
In-Reply-To: <20171214180449.GU14433@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci
 for inter-VM communication
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/15/2017 02:04 AM, Stefan Hajnoczi wrote:
> On Thu, Dec 14, 2017 at 01:53:16PM +0800, Wei Wang wrote:
>> 3rd one: I'm not able to solve this one, as discussed, there are too many
>> differences and it's too complex. I prefer the direction of simply gating
>> the vhost-user protocol and deliver to the guest what it should see (just
>> what this patch series shows). You would need to solve this issue to show
>> this direction is simpler :)
> At the moment the main issue deciding what to do seems to be that we
> have no patches for the approach I've described.  I'll begin working on
> a patch series.


Are you planning to implement the multiple masters and slaves?
Master-->QemuSlave1-->GuestSlave
Master<--QemuSlave2<--GuestSlave



> If there is something else you think I could help with, please let me
> know.  I'd like to contribute to vhost-pci.
>

Thanks.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

