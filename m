Return-Path: virtio-dev-return-2985-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BBD7B5818CB1
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 Jan 2018 02:45:23 -0800 (PST)
Message-ID: <5A5F29C9.4040706@intel.com>
Date: Wed, 17 Jan 2018 18:47:37 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516165812-3995-1-git-send-email-wei.w.wang@intel.com> <1516165812-3995-3-git-send-email-wei.w.wang@intel.com> <1003745745.1007975.1516177271163.JavaMail.zimbra@redhat.com> <5A5F109B.7090200@intel.com> <1239524301.1023371.1516181271621.JavaMail.zimbra@redhat.com>
In-Reply-To: <1239524301.1023371.1516181271621.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v22 2/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang opensource <liliang.opensource@gmail.com>, yang zhang wz <yang.zhang.wz@gmail.com>, quan xu0 <quan.xu0@gmail.com>, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/17/2018 05:27 PM, Pankaj Gupta wrote:
>> On 01/17/2018 04:21 PM, Pankaj Gupta wrote:
>>
> o.k  you have initialize "err = -ENOMEM;"
>
> Remove these four lines.
>   
>   -        kfree(names);
>   -        kfree(callbacks);
>   -        kfree(vqs);
>   -        return 0;
>
>   +        err = 0;              // if executed without any error
>

OK, thanks. "error = 0" is not needed actually.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

