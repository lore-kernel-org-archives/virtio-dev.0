Return-Path: <virtio-dev-return-10870-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7BA0986586
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Feb 2023 12:30:03 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230209071430-mutt-send-email-mst@kernel.org>
References: <20230209014108.209950-1-parav@nvidia.com>
 <20230209071430-mutt-send-email-mst@kernel.org>
Date: Thu, 09 Feb 2023 13:29:57 +0100
Message-ID: <877cwr6myi.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3] virtio-net: Improve introductory description
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 09, 2023 at 03:41:08AM +0200, Parav Pandit wrote:
>> @@ -389,8 +392,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>>  };
>>  \end{lstlisting}
>>  
>> -The controlq is used to control device features such as
>> -filtering.
>> +The controlq is used to control many device features described further in
>
> many seems subjective.
>
> s/many/some of the/ ?

s/many/various/ instead? That section should cover all of the device
features controled via the control vq.

>
>> +section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

