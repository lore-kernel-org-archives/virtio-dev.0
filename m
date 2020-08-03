Return-Path: virtio-dev-return-7624-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA7E89849ED
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Aug 2020 16:23:26 +0000 (UTC)
References: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
 <87ft973d0b.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87ft973d0b.fsf@linaro.org>
Date: Mon, 03 Aug 2020 17:19:56 +0100
Message-ID: <87wo2fn1lf.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 0/5] virtio mmio specification enhancement
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Pincus, Josh" <Josh.Pincus@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "zhabin@linux.alibaba.com" <zhabin@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Pincus, Josh <Josh.Pincus@windriver.com> writes:
>
>> Hi,
>>
>> =20
>>
>> We were looking into a similar enhancement for the Virt I/O MMIO transpo=
rt and came across this project.
>>
>> This enhancement would be perfect for us.
>
> So there is certainly an interest in optimising MMIO based virtio and
> the current read/ack cycle adds additional round trip time for any trap
> and emulate hypervisor. However I think there is some resistance to
> making MMIO a re-implementation of what PCI already gives us for "free".
<snip>
>
>   - Quantifying the memory foot-print difference between PCI/MMIO
>
>     PCI gives a lot for free including a discovery and IRQ model already
>     designed to handle MSI/MSI-X. There is a claim that this brings in a
>     lot of bloat but I think there was some debate around the numbers.
>     My rough initial experiment with a PCI and non-PCI build with
>     otherwise identical VIRTIO configs results in the following:
>
>     16:40:15 c.282% [alex@zen:~/l/l/builds] review/rpmb|=E2=80=A6 + ls -l=
 arm64/vmlinux arm64.nopci/vmlinux
>     -rwxr-xr-x 1 alex alex 83914728 Jul 31 16:39 arm64.nopci/vmlinux*
>     -rwxr-xr-x 1 alex alex 86368080 Jul 31 16:33 arm64/vmlinux*
>
>     which certainly implies there could be a fair amount of headroom for
>     an MMIO version to implement some features. However I don't know if
>     it's fully apples to apples as there maybe unneeded PCI bloat that a
>     virtio-only kernel doesn't need.

Just following up after cutting the Xgene and ThunderX PCI bloat from
the kernel the margin is a little smaller:

  -rwxr-xr-x 1 alex alex 83914728 Jul 31 16:39 arm64.nopci/vmlinux*
  -rwxr-xr-x 1 alex alex 85639808 Aug  3 17:12 arm64/vmlinux*

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

