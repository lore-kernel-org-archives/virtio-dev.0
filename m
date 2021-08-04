Return-Path: <david@redhat.com>
Subject: Re: [virtio-dev] [PATCH RESEND] virtio-pmem: PMEM device spec
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <YQp1D+Ece28livMx@stefanha-x1.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dee2aab6-c0a7-3af6-4d4a-f0be75e2a92b@redhat.com>
Date: Wed, 4 Aug 2021 13:11:52 +0200
MIME-Version: 1.0
In-Reply-To: <YQp1D+Ece28livMx@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stefan Hajnoczi <stefanha@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, dan.j.williams@intel.com, mst@redhat.com, cohuck@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 04.08.21 13:07, Stefan Hajnoczi wrote:
> On Wed, Jul 28, 2021 at 05:04:35PM +0200, Pankaj Gupta wrote:
>> Posting virtio specification for virtio pmem device. Virtio pmem is a
>> paravirtualized device which allows the guest to bypass page cache.
>> Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
>> device is merged in Qemu 4.1.
>>
>> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> ---
>> Sorry, It took me long time to get back on this. There is
>> an enhancement to this spec by "Taylor Stark" CCed in the list.
>> Request for feedback and merging.
>>
>> RFC is posted here [1]
>> [1] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
> 
> I skimmed through the review comments but pretty much reviewed this
> patch from scratch. Feel free to ignore questions that others have
> already raised.
> 
>>
>>   conformance.tex |  19 ++++++-
>>   content.tex     |   1 +
>>   virtio-pmem.tex | 132 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 150 insertions(+), 2 deletions(-)
>>   create mode 100644 virtio-pmem.tex
>>
>> diff --git a/conformance.tex b/conformance.tex
>> index 94d7a06..818ddda 100644
>> --- a/conformance.tex
>> +++ b/conformance.tex
>> @@ -31,7 +31,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
>>   \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
>>   \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
>> -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
>> +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
>> +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
>>   
>>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>>     \end{itemize}
>> @@ -55,7 +56,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
>>   \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
>>   \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance} or
>> -\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
>> +\ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
>> +\ref{sec:Conformance / Device Conformance / PMEM Driver Conformance}.
>>   
>>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>>     \end{itemize}
>> @@ -301,6 +303,19 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{drivernormative:Device Types / SCMI Device / Device Operation / Setting Up eventq Buffers}
>>   \end{itemize}
>>   
>> +\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance / Driver Conformance / PMEM Driver Conformance}
>> +
>> +A PMEM driver MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{devicenormative:Device Types / PMEM Device / Device Initialization}
>> +\item \ref{drivernormative:Device Types / PMEM Driver / Driver Initialization / Direct access}
>> +\item \ref{drivernormative:Device Types / PMEM Driver / Driver Initialization / Virtio flush}
>> +\item \ref{drivernormative:Device Types / PMEM Driver / Driver Operation / Virtqueue command}
>> +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue flush}
>> +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
>> +\end{itemize}
>> +
>>   \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>>   
>>   A device MUST conform to the following normative statements:
>> diff --git a/content.tex b/content.tex
>> index ceb2562..6acc785 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -6583,6 +6583,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>>   \input{virtio-mem.tex}
>>   \input{virtio-i2c.tex}
>>   \input{virtio-scmi.tex}
>> +\input{virtio-pmem.tex}
>>   
>>   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   
>> diff --git a/virtio-pmem.tex b/virtio-pmem.tex
>> new file mode 100644
>> index 0000000..a2b888e
>> --- /dev/null
>> +++ b/virtio-pmem.tex
>> @@ -0,0 +1,132 @@
>> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
>> +
>> +The virtio pmem is a fake persistent memory (NVDIMM) device
> 
> s/fake/virtual/ or drop "fake"? If the device persists data correctly
> then it's not fake.
> 
>> +used to bypass the guest page cache and provide a virtio
>> +based asynchronous flush mechanism.This avoids the need
>> +of a separate page cache in guest and keeps page cache only
>> +in the host. Under memory pressure, the host makes use of
>> +effecient memory reclaim decisions for page cache pages
> 
> s/effecient/efficient/
> 
>> +of all the guests. This helps to reduce the memory footprint
>> +and fit more guests in the host system.
> 
> This explains the motivation for the device. It would also be nice to
> explain the nature of the device:
> 
>    The virtio pmem device provides access to byte-addressable persistent
>    memory. The persist memory is directly accessible as a Shared Memory
>    Region. Data written to this memory is made persistent by separately
>    sending a flush command. Writes that have been flushed are preserved
>    across device reset and power failure.
> 
>> +
>> +\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
>> +  27
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / PMEM Device / Virtqueues}
>> +\begin{description}
>> +\item[0] req_vq
>> +\end{description}
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / PMEM Device / Feature bits}
>> +
>> +There are currently no feature bits defined for this device.
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / PMEM Device / Device configuration layout}
>> +
>> +\begin{lstlisting}
>> +struct virtio_pmem_config {
>> +	le64 start;
>> +	le64 size;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{description}
>> +\item[\field{start}] contains the start address from the guest physical address range
>> +to be hotplugged into the guest address space using the pmem API.
>> +
>> +\item[\field{size}] contains the length of this address range.
>> +\end{description}
> 
> Please use a Shared Memory Region instead. This is a relatively new
> addition to the VIRTIO device model that seems like a good fit for this
> device:
> https://github.com/oasis-tcs/virtio-spec/blob/master/shared-mem.tex

Note that virtio-pmem is already upstream in QEMU and in Linux using 
this model. There is a proposal to optionally use shared memory for 
exposing the area, to be unlocked with a feature bit.


-- 
Thanks,

David / dhildenb

