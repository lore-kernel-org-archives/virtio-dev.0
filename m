Return-Path: virtio-comment-return-1623-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
 <20210106181158.GC133350@stefanha-x1.localdomain>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <fe9f61aa-f5e3-6a18-ae1d-e2e7eec7692c@intel.com>
Date: Thu, 7 Jan 2021 09:19:55 +0800
MIME-Version: 1.0
In-Reply-To: <20210106181158.GC133350@stefanha-x1.localdomain>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/1/7 2:11, Stefan Hajnoczi wrote:
> On Thu, Dec 24, 2020 at 04:10:43PM +0800, Jie Deng wrote:
>> +\begin{lstlisting}
>> +struct virtio_i2c_out_hdr {
>> +        le16 addr;
>> +        le16 padding;
>> +        le32 flags;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{lstlisting}
>> +struct virtio_i2c_in_hdr {
>> +        u8 status;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{lstlisting}
>> +struct virtio_i2c_req {
>> +        struct virtio_i2c_out_hdr out_hdr;
>> +        u8 write_buf[];
>> +        u8 read_buf[];
>> +        struct virtio_i2c_in_hdr in_hdr;
>> +};
>> +\end{lstlisting}
> I didn't notice that the written and read fields were removed. Does this
> mean that struct virtio_i2c_req can either be read or write, but not
> read+write?

It can be read, write or read+write.

written/read are removed according to Michael's suggest. He preferred to 
directly use the read/write flags in descriptors.

Please refer to 
https://lists.oasis-open.org/archives/virtio-comment/202012/msg00045.html

> This makes sense if virtqueue buffers can be grouped together so
> bi-directional transfers can be described using multiple buffers. Just
> wanted to check if I understand this correctly.
>
> Thanks,
> Stefan

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

