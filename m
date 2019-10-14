Return-Path: virtio-dev-return-6234-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05EDE984325
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Oct 2019 08:49:56 +0000 (UTC)
References: <e0fb8838-c6c2-4c1e-4a14-d0b2671c524a@siemens.com>
 <20191014084502.GG22963@stefanha-x1.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <33e8a792-b27a-194e-ebe9-ed3795607c3e@siemens.com>
Date: Mon, 14 Oct 2019 10:49:53 +0200
MIME-Version: 1.0
In-Reply-To: <20191014084502.GG22963@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] virtio-mmio: Rename remaining
 QueueAvail/Used references
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 14.10.19 10:45, Stefan Hajnoczi wrote:
> On Sun, Oct 06, 2019 at 06:41:32PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> These have been changed in ae98c6bc21bc. Convert the rest.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  content.tex | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Please create a GitHub Issue so that a vote can be started:
> https://github.com/oasis-tcs/virtio-spec/issues
> 

Done: https://github.com/oasis-tcs/virtio-spec/issues/52

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

