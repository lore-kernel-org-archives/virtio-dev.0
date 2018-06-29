Return-Path: virtio-dev-return-4611-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D31758191AB
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Jun 2018 09:03:23 -0700 (PDT)
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
 <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
 <5B35ACD5.4090800@intel.com>
 <4840cbb7-dd3f-7540-6a7c-13427de2f0d1@redhat.com>
 <5B36189E.5050204@intel.com>
 <34bb25eb-97f3-8a9f-8a13-401dfcf39a2c@redhat.com>
 <286AC319A985734F985F78AFA26841F7396C254C@shsmsx102.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <745eb950-eb52-e32a-b006-5612a026c2dc@redhat.com>
Date: Fri, 29 Jun 2018 18:03:09 +0200
MIME-Version: 1.0
In-Reply-To: <286AC319A985734F985F78AFA26841F7396C254C@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
To: "Wang, Wei W" <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


>> Why would your suggestion still be applicable?
>>
>> Your point for now is "I might not want to have page hinting enabled due to
>> the overhead, but still a live migration speedup". If that overhead actually
>> exists (we'll have to see) or there might be another reason to disable page
>> hinting, then we have to decide if that specific setup is worth it merging your
>> changes.
> 
> All the above "if we have", "assume we have" don't sound like a valid argument to me.

Argument? *confused* And that hinders you from answering the question
"Why would your suggestion still be applicable?" ? Well, okay.

So I will answer it by myself: Because somebody would want to disable
page hinting. Maybe there are some people out there.

>  
>> I am not (and don't want to be) in the position to make any decisions here :) I
>> just want to understand if two interfaces for free pages actually make sense.
> 
> I responded to Nitesh about the differences, you may want to check with him about this.
> I would suggest you to send out your patches to LKML to get a discussion with the mm folks.

Indeed, Nitesh is trying to solve the problems we found in the RFC, so
this can take some time.

> 
> Best,
> Wei
> 


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

