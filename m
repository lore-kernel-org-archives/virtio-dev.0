Return-Path: virtio-dev-return-2625-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B925D58191C4
	for <virtio-dev@lists.oasis-open.org>; Tue, 24 Oct 2017 17:46:10 -0700 (PDT)
Message-ID: <59EFDF4F.8050708@intel.com>
Date: Wed, 25 Oct 2017 08:48:15 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <B84047ECBD981D4B93EAE5A6245AA361013EF401@FRAEML521-MBX.china.huawei.com> <20171025012316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171025012316-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] vhost-user to interconnect vm's
To: "Michael S. Tsirkin" <mst@redhat.com>, "Avi Cohen (A)" <avi.cohen@huawei.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Ofer Ben-Yacov <ofer.benyacov@toganetworks.com>, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/25/2017 06:25 AM, Michael S. Tsirkin wrote:
> On Tue, Oct 24, 2017 at 02:07:21PM +0000, Avi Cohen (A) wrote:
>> Hello,
>> I wonder if it is possible to directly connect 2  VM's (without host intervention) with  vhost-user interface , so one VM is slave and the 2nd  is the master.
>> I can connect the VM's with OVS-DPDK (or VPP)  in the middle - but this requires an extra copy.
>> Best Regards
>> Avi
>
> This is the vhost-pci set of patches. They are not upstream yet -
> last version - v2 - was posted back in May. Cc Wei Wang for an
> update on the status. It would be great if you could try them out.


We have started to implement the DPDK PMD of vhost-pci, since
it is simpler and has better performance than the kernel driver.

We are also trying to make a simpler QEMU implementation than v2,
for example, the vhost-pci device will be statically set up via qemu
command line, instead of being hot-plugged on demand.

We would be able to send out the new version in a month or two.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

