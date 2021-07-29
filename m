Return-Path: <virtio-dev-return-8429-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06C7A986134
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jul 2021 05:39:21 +0000 (UTC)
References: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <7c74b6aa-5d1d-8ab1-b4ca-e1f9df8b6605@intel.com>
Date: Thu, 29 Jul 2021 13:39:16 +0800
MIME-Version: 1.0
In-Reply-To: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
Subject: [virtio-dev] Re: [PATCH] virtio: i2c: Allow buffer less transactions
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/7/23 13:26, Viresh Kumar wrote:

> +
> +\item[VIRTIO_I2C_FLAGS_M_RD(1)] is used to mark the request as READ or WRITE.
>   \end{description}
>   
>   Other bits of \field{flags} are currently reserved as zero for future feature
>   extensibility.
>   
> -The \field{write_buf} of the request contains one segment of an I2C transaction
> -being written to the device.
> -
> -The \field{read_buf} of the request contains one segment of an I2C transaction
> -being read from the device.
> +The \field{buf} of the request is optional and contains one segment of an I2C
> +transaction being read from or written to the device, based on the value of the
> +\field{VIRTIO_I2C_FLAGS_M_RD} bit in the \field{flags} field.


I removed this flag from the initial version according to Michael's 
suggestion by asking

the device take the information from the virtio descriptor. But it seems 
we need this

flag now for zero-length request since buf become optional.


Well, then can we also add a flag to mark the zero-length request.

I think it will be convenient for backend developers.


>   
>   The final \field{status} byte of the request is written by the device: either
>   VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
> @@ -103,27 +102,27 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
>   #define VIRTIO_I2C_MSG_ERR    1
>   \end{lstlisting}
>   
> -If ``length of \field{read_buf}''=0 and ``length of \field{write_buf}''>0,
> -the request is called write request.
> +If \field{VIRTIO_I2C_FLAGS_M_RD} bit is set in the \field{flags}, then the
> +request is called a read request.
>   
> -If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=0,
> -the request is called read request.
> +If \field{VIRTIO_I2C_FLAGS_M_RD} bit is unset in the \field{flags}, then the
> +request is called a write request.
>   
> -If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''>0,
> -the request is called write-read request. It means an I2C write segment followed
> -by a read segment. Usually, the write segment provides the number of an I2C
> -controlled device register to be read.
> +The \field{buf} is optional and may not be present for some of the requests,
> +like SMBus Quick.


Can we add some words to explain buf is optional because it is 
*zero-length* request ?

I think zero-length is clearer than SMBus Quick.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

