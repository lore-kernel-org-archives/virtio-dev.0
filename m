Return-Path: virtio-dev-return-5932-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 168DC985D66
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Aug 2019 11:24:23 +0000 (UTC)
Date: Tue, 6 Aug 2019 07:24:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190806045914-mutt-send-email-mst@kernel.org>
References: <1565064256-13530-1-git-send-email-yang.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565064256-13530-1-git-send-email-yang.huang@intel.com>
Subject: [virtio-dev] Re: [PATCH v3] It is a virtio based RPMB (Replay Protected Memory
 Block) device.
To: Huang Yang <yang.huang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, bing.zhu@intel.com, tomas.winkler@intel.com, peter.fang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 06, 2019 at 12:04:16PM +0800, Huang Yang wrote:
> Signed-off-by: Yang Huang <yang.huang@intel.com>
> Reviewed-by: Bing Zhu <bing.zhu@intel.com>
> Reviewed-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> v2 -> v3:
> 1. Remove conformance changes temporarily
>    since the draft requires reviews and updates at this phase.
> 2. Add eMMC, UFS and NVMe as Normative References.
> 3. Add more details on:
>    RPMB frame
>    Request Type/Response Type
> 4. Add differentiation JEDEC RPMB and NVMe RPMB.
> 5. Define config layout
> 6. Illustrate behaviors of all RPMB requests
> 7. Remove RPMB device ID reservation,
>    it will be submitted with an independent patch.
> ---
>  content.tex      |   1 +
>  introduction.tex |   9 ++
>  virtio-rpmb.tex  | 269 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 virtio-rpmb.tex
> 
> diff --git a/content.tex b/content.tex
> index ee0d7c9..2573bd5 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5677,6 +5677,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  \input{virtio-input.tex}
>  \input{virtio-crypto.tex}
>  \input{virtio-vsock.tex}
> +\input{virtio-rpmb.tex}
>  
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  
> diff --git a/introduction.tex b/introduction.tex
> index c96acf9..2579bf3 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -60,6 +60,15 @@ \section{Normative References}\label{sec:Normative References}
>  	\phantomsection\label{intro:SCSI MMC}\textbf{[SCSI MMC]} &
>          SCSI Multimedia Commands,
>          \newline\url{http://www.t10.org/cgi-bin/ac.pl?t=f&f=mmc6r00.pdf}\\
> +        \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
> +        eMMC Electrical Standard (5.1),
> +        \newline\url{https://www.jedec.org/standards-documents/docs/jesd84-b51}\\
> +        \phantomsection\label{intro:UFS}\textbf{[UFS]} &
> +        UNIVERSAL FLASH STORAGE (UFS), Version 3.0,
> +        \newline\url{https://www.jedec.org/standards-documents/docs/jesd220c}\\
> +        \phantomsection\label{intro:NVMe}\textbf{[NVMe]} &
> +        NVM Express, Revision 1.3
> +        \newline\url{https://www.nvmexpress.org/wp-content/uploads/NVM_Express_Revision_1.3.pdf}\\
>  
>  \end{longtable}
>  

At this stage I suggest we avoid nvme. Mix of LE and BE
in the frame is just too nasty. And ATM Linux only supports
UFS/MMC.



Second, please assess the relevance of anything you copy to virtual
devices. Copying things like padding does not buy us anything,
and just creates work where we need to zero this out.

The only thing that must match if you are passing
through a hardware device is the size and order of
keys.



> diff --git a/virtio-rpmb.tex b/virtio-rpmb.tex
> new file mode 100644
> index 0000000..c2357af
> --- /dev/null
> +++ b/virtio-rpmb.tex
> @@ -0,0 +1,269 @@
> +\section{RPMB Device}\label{sec:Device Types / RPMB Device}
> +
> +virtio-rpmb is a virtio based RPMB (Replay Protected Memory Block)
> +device. It is used as a tamper-resistant and anti-replay storage.
> +The device is driven via requests including read, write, get write
> +counter and program key, which are submitted via a request queue.
> +This section relies on definitions from paragraph 6.6.22 of
> +\hyperref[intro:eMMC]{eMMC}, 12.4 of \hyperref[intro:UFS]{UFS}
> +and 8.10 of \hyperref[intro:NVMe]{NVMe}.







> +\subsection{Device ID}\label{sec:Device Types / RPMB Device / Device ID}
> +
> +28
> +
> +\subsection{Virtqueues}\label{sec:Device Types / RPMB Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] requestq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / RPMB Device / Feature bits}
> +
> +None.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / RPMB Device / Device configuration layout}
> +
> +All fields of this configuration are always available.
> +
> +\begin{lstlisting}
> +enum virtio_rpmb_type {
> +        RPMB_TYPE_JEDEC,
> +        RPMB_TYPE_NVME,

enum {} has no meaning in spec. any constants must be defined.

> +};
> +

Do we have to expose the type?  I think we need feature bits
for various things so we can split them out later.



> +struct virtio_rpmb_config {
> +        u8 capacity;
> +        u8 max_wr_cnt;
> +        u8 max_rd_cnt;
> +        u8 id;
> +        u8 type;
> +}

How about adding a key programmed state here?


> +\end{lstlisting}


Why not put the counter here?

Are all fields read-only?

> +
> +\begin{description}
> +\item[\field{capacity}] is the capacity of the device (expressed in 128KB units).
> +   The values MUST range between 0x00 and 0x80 inclusive for JEDEC device, and
> +   0x00 and 0xFF inclusive for NVMe device.

I'd just drop this. u8 so up to 0xff anyway, and I don't think
any users care that there are a couple of extra bytes.

Thinking about it, 32Mbytes isn't huge at all. Why not allow larger
capacity?




> +\item[\field{max_wr_cnt and max_rd_cnt}] are the maximum numbers of RPMB
> +   block count that can be performed to device in one request. 0 implies
> +   no limitation.

I don't understand what does block count mean in this context.

> +\item[\field{id}] is the identifier of RPMB partitions.

What does this mean? what are the partitions? Did you mean of the device?

I suspect what is going on is there's an actual device behind this,
and this is its ID. Which again begs the question whether this
should just be a part of a blk or scsi device.


> +\item[\field{type}] is the rpmb type that device emulates. RPMB_TYPE_JEDEC
> +   refers to eMMC or UFS while RPMB_TYPE_NVME refers to NVMe.
> +\end{description}

Does not look like we emulate anything.

> +
> +\devicenormative{\subsection}{Device Initialization}{Device Types / RPMB Device / Device Initialization}
> +
> +\begin{enumerate}
> +\item The virtqueue is initialized.
> +\item The authentication key of device MUST NOT be programmed at the first device initialization.

What is "first device initialization"? The concept does not seem to apply
to virtual devices. How about we just have device pre-initialized to
some key? Or maybe device can be in two states, key programming
and operation?


All conformance clauses belong in conformance sections.  here and elsewhere.

> +\item The device capacity MUST be initialized to a multiple of 128Kbytes and up to
> +    16Mbytes/32Mbytes (JEDEC/NVMe device respectively).
> +\end{enumerate}

So instead of blindly copying limitations of physical devices,
we can just allow hypervisor to set any capacity.

> +
> +\subsection{Device Operation}\label{sec:Device Types / RPMB Device / Device Operation}
> +
> +The operation of a virtio RPMB device is driven by the requests placed on the virtqueue.
> +  The type of the request can be program key (VIRTIO_RPMB_REQ_PROGRAM_KEY),
> +  get write counter (VIRTIO_RPMB_REQ_GET_WRITE_COUNTER),
> +  write (VIRTIO_RPMB_REQ_DATA_WRITE), and read (VIRTIO_RPMB_REQ_DATA_READ).
> +  A program key or write request can also combine with a
> +  result read (VIRTIO_RPMB_REQ_RESULT_READ) for a returned result.
> +
> +\begin{lstlisting}
> +/* RPMB Request Types */
> +#define VIRTIO_RPMB_REQ_PROGRAM_KEY        0x0001
> +#define VIRTIO_RPMB_REQ_GET_WRITE_COUNTER  0x0002
> +#define VIRTIO_RPMB_REQ_DATA_WRITE         0x0003
> +#define VIRTIO_RPMB_REQ_DATA_READ          0x0004
> +#define VIRTIO_RPMB_REQ_RESULT_READ        0x0005
> +\end{lstlisting}
> +
> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / RPMB Device / Device Operation / Device Operation: Request Queue}
> +
> +The request information is delivered in RPMB frame.
> +The frame is in size of 512B for JEDEC RPMB, and in size of 256B plus
> +multiple 512B for NVMe RPMB depending on the variable data size.

Again this is just messy. Let's come up with a minimal spec.
See end of the message pls.

> +
> +\begin{lstlisting}
> +struct virtio_rpmb_frame_jedec {
> +        u8 stuff[196];
> +        u8 key_mac[32];
> +        u8 data[256];
> +        u8 nonce[16];
> +        be32 write_counter;
> +        be16 address;
> +        be16 block_count;
> +        be16 result;
> +        be16 req_resp;
> +};
> +
> +struct virtio_rpmb_frame_nvme {
> +        u8 stuff [191];
> +        u8 key_mac[32];
> +        u8 rpmb_target;
> +        u8 nonce[16];
> +        le32 write_counter;
> +        le32 address;
> +        le32 block_count;
> +        le16 result;
> +        le16 req_resp;
> +        u8 data[0];
> +};

Oh fun, a mix of LE and BE.

Let's make everything consistent.

Why do we need the "stuff" field? It helps align the size to 256
byte boundary - but why do we care?



> +
> +/* RPMB Response Types */
> +#define VIRTIO_RPMB_RESP_PROGRAM_KEY           0x0100
> +#define VIRTIO_RPMB_RESP_GET_COUNTER           0x0200
> +#define VIRTIO_RPMB_RESP_DATA_WRITE            0x0300
> +#define VIRTIO_RPMB_RESP_DATA_READ             0x0400
> +
> +/* RPMB Operation Results */
> +#define VIRTIO_RPMB_RES_OK                     0x0000
> +#define VIRTIO_RPMB_RES_GENERAL_FAILURE        0x0001
> +#define VIRTIO_RPMB_RES_AUTH_FAILURE           0x0002
> +#define VIRTIO_RPMB_RES_COUNT_FAILURE          0x0003
> +#define VIRTIO_RPMB_RES_ADDR_FAILURE           0x0004
> +#define VIRTIO_RPMB_RES_WRITE_FAILURE          0x0005
> +#define VIRTIO_RPMB_RES_READ_FAILURE           0x0006
> +#define VIRTIO_RPMB_RES_NO_AUTH_KEY            0x0007
> +#define VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED  0x0080
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{stuff}] Padding for the frame.
> +
> +\item[\field{key_mac}] is the authentication key or the message
> +   authentication code (MAC) depending on the request/response type.
> +   If the request is VIRTIO_RPMB_REQ_PROGRAM_KEY, it's used as
> +   authentication key. Otherwise, it's used as MAC. The MAC is calculated
> +   using HMAC SHA-256.

SHA-256 is pretty old. Not being a cryptographer I don't really
know whether it's still a good mac to use in 2019.

Generally security considerations should probably be presented
with anything dealing with crypto.
In this case, I'd do a feature bit so we can change the crypto
down the road.


> It takes as input a key and a message. The key
> +   used for the MAC calculation is always the 256 bit RPMB authentication
> +   key. The message used as input to the MAC calculation is the
> +   concatenation of the fields in the RPMB frames excluding stuff bytes
> +   and the MAC itself.
> +
> +\item[\field{rpmb_target}] is the exclusive item for NVMe device. It is
> +   the RPMB target to access.

There are multiple targets too?

> +
> +\item[\field{data}] is used to be written or read by signed access.

What does signed access mean?

> It's
> +   fixed 256B for JEDEC device while variable sized payload
> +   512 * \field{block_count} for NVMe device.
> +
> +\item[\field{nonce}] is a random number


random how? I think it can just be anything.


> generated by user for the read or
> +   get write counter requests and copied to the response by device.
> +
> +\item[\field{writer_counter}] is the counter value for the total amount of
> +   the successful authenticated data write requests.
> +
> +\item[\field{address}] is the address of the data to be written to or read
> +   from the RPMB virtio device. It is the serial number of the accessed
> +   half sector (256B for JEDEC device) or sector (512B for NVMe device).

serial number?

> +
> +\item[\field{block_count}] is the number of blocks (256B for JEDEC and 512B
> +   for NVMe) requested to be read/written.

can't this be intuited from the buffer size somehow?

I don't really understand how can you both have block_count
and a fixed size data. how does this make sense?


> +
> +\item[\field{result}] includes information about the status of access made
> +   to the device.
> +

So I am guessing result is written by the device?
And type is written by the driver?
this does not play well with virtio where write
fields are followed by read fields.


> +\item[\field{req_resp}] is the type of request or response, as defined above,
> +   to/from the device.

this seems to be the 1st definition. Please avoid "above" and "below",
just link to the definition.

> +\end{description}
> +
> +\devicenormative{\paragraph}{Device Operation: Request Queue}{Device Types / RPMB Device / Device Operation / Device Operation: Request Queue}
> +
> +The device MUST parse the request from the request queue and emulate the behaviours described in paragraph
> +6.6.22 of \hyperref[intro:eMMC]{eMMC}, 12.4 of \hyperref[intro:UFS]{UFS} or 8.10 of \hyperref[intro:NVMe]{NVMe}:

If you are going to emulate existing specs, then why not just emulate an
existing spec? Why bother with virtio at all? You gain ability to use
existing drivers.

If the reason is to make a clean abstraction, then IMHO this falls short
of this goal, carrying on all kind of baggage from hardware specs.

> +
> +\begin{description}
> +
> +\item[VIRTIO_RPMB_REQ_PROGRAM_KEY] If block count has not been set to 1
> +   then VIRTIO_RPMB_RES_GENERAL_FAILURE is responded. If programming of
> +   authentication key fails then returned result is VIRTIO_RPMB_RES_WRITE_FAILURE.
> +   If some other error occurs then returned result is VIRTIO_RPMB_RES_GENERAL_FAILURE.
> +   The \field{req_resp} value VIRTIO_RPMB_RESP_PROGRAM_KEY corresponds to
> +   the key programming request.
> +
> +   If VIRTIO_RPMB_REQ_RESULT_READ is requested, the device returns the RPMB frame
> +   with response (VIRTIO_RPMB_RESP_PROGRAM_KEY), the calculated MAC and the result.

I don't see what does VIRTIO_RPMB_REQ_RESULT_READ buy us.
I guess it proves key has been programmed - but if someone
can snoop on programming then for sure he has the key
and won't have trouble faking the mac.

> +
> +\item[VIRTIO_RPMB_REQ_GET_WRITE_COUNTE] If the authentication key is not yet
> +   programmed then VIRTIO_RPMB_RES_NO_AUTH_KEY is returned in \field{result}.
> +   If block count has not been set to 1 then VIRTIO_RPMB_RES_GENERAL_FAILURE
> +   SHOULD be responded.
> +
> +   The device returns the RPMB frame with response (VIRTIO_RPMB_RESP_GET_COUNTER),
> +   the writer counter, a copy of the nonce received in the request, the calculated
> +   MAC and the result.
> +
> +\item[VIRTIO_RPMB_REQ_DATA_WRITE] If the authentication key is not yet programmed
> +   then VIRTIO_RPMB_RES_NO_AUTH_KEY is returned in \field{result}. If block count
> +   is zero or greater than \field{max_wr_cnt} then VIRTIO_RPMB_RES_GENERAL_FAILURE
> +   MUST be responded. The device MUST check whether the write counter has expired.
> +   If the write counter is expired then sets the \field{result} to
> +   VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED. If there is an error in the address
> +   (out of range) then the \field{result} is set to VIRTIO_RPMB_RES_ADDR_FAILURE.
> +   The device MUST calculate the MAC taking authentication key and frame as input,
> +   and compares this with the MAC in the request. If the two MAC’s are different
> +   then VIRTIO_RPMB_RES_AUTH_FAILURE is returned.
> +
> +   If the writer counter in the request with is different from the one maintained
> +   by device then VIRTIO_RPMB_RES_COUNT_FAILURE is returned in \field{result}.
> +   If the MAC and write counter comparisons are successful then the write request
> +   is considered to be authenticated. The data from the request are written to the
> +   address indicated in the request and the write counter is incremented by 1.
> +   If write fails then returned result is VIRTIO_RPMB_RES_WRITE_FAILURE. If some
> +   other error occurs during the write procedure then returned result is
> +   VIRTIO_RPMB_RES_GENERAL_FAILURE.
> +
> +   If VIRTIO_RPMB_REQ_RESULT_READ is requested, the device returns the RPMB data
> +   frame with response (VIRTIO_RPMB_RESP_DATA_WRITE), the incremented counter value,
> +   the data address, the calculated MAC and result.
> +
> +\item[VIRTIO_RPMB_REQ_DATA_READ] If the authentication key is not yet programmed
> +   then VIRTIO_RPMB_RES_NO_AUTH_KEY is returned in \field{result}. If block count
> +   has not been set to 1 then VIRTIO_RPMB_RES_GENERAL_FAILURE MUST be responded.
> +   If there is an error in the address (out of range) then the \field{result} is
> +   set to VIRTIO_RPMB_RES_ADDR_FAILURE. If data fetch from addressed location inside
> +   device fails then returned result is VIRTIO_RPMB_RES_READ_FAILURE. If some other
> +   error occurs during the read procedure then returned result is
> +   VIRTIO_RPMB_RES_GENERAL_FAILURE.
> +
> +   The device returns the RPMB frame with response (VIRTIO_RPMB_RESP_DATA_READ),
> +   the block count, a copy of the nonce received in the request, the address,
> +   the data, the calculated MAC, and the result.
> +
> +\item[VIRTIO_RPMB_REQ_RESULT_READ] It is used following with the other request
> +   types for returned result in one or multiple RPMB frames.

So each write request must be followed by a status request.  This just
seems like a waste. Why not return the result immediately with the
operation?  Maybe UFS doesn't support this but virtio sure does.


Does device have to maintain the last request in non-volatile memory and
persist across resets?  You do not list it as being
persistent below. So I would just drop this request type
and have driver maintain it in guest memory.

> For
> +   VIRTIO_RPMB_REQ_PROGRAM_KEY and VIRTIO_RPMB_REQ_DATA_WRITE, if block count has
> +   not been set to 1 of VIRTIO_RPMB_REQ_RESULT_READ request, then
> +   VIRTIO_RPMB_RES_GENERAL_FAILURE SHALL be indicated.
> +
> +\end{description}
> +If authetication key was programmed successfully, the device SHALL return with a MAC for any operation requests.

Lots of typos above make it pretty hard to figure out.

> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
> +
> +The driver MUST configure and initialize virtqueue for the requests received.

received where? why isn't it legal to e.g. check feature bits and
then reset?

> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
> +
> +The virtio-rpmb device could be backed in a number of ways. It SHOULD
> +   keep consistent behaviors with hardware as described in paragraph
> +   6.6.22 of \hyperref[intro:eMMC]{eMMC}, 12.4 of \hyperref[intro:UFS]{UFS}
> +   or 8.10 of \hyperref[intro:NVMe]{NVMe}.
> Some elements are maintained
> +   by the device:
> +\begin{enumerate}
> +\item The device maintains an one time programmable authentication key.
> +   It cannot be overwritten, erased or read. The key is used to
> +   authenticate the accesses when MAC is calculated. This key MUST be
> +   kept regardless of device reset or reboot.
> +\item The device maintains a read-only monotonic write counter. It MUST
> +   be initialized to zero and added by one automatically along with
> +   successful write operation. The value cannot be reset. After
> +   the counter has reached its maximum value 0xFFFF FFFF, it will
> +   not be incremented anymore. This counter MUST be kept regardless
> +   of device reset or reboot.
> +\item The device maintains the data for read/write via authenticated
> +   access.
> +\end{enumerate}
> +



What I have gathered from above is really just a counter and a key
added to a storage device.

	Key: you must have the key to write. It's programmed into the
	device at some point by manufacturer.
	So later, only someone who got key from manufacturer can write.
	Data is also authenticated with the key, so if you got
	the key from manufacturer you can verify it's valid.

	What if you didn't get the key but you steal the data
	in transit to storage device somehow? You could
	replay it to the device and overwrite valid data.
	To this end device maintains write counter,
	so you can't.

	What if you can pretend write failed, or filter out writes to pretend
	they succeeded? First write counter will be wrong, but it's tricky for
	applications to verify the counter: after all an application can crash.
	So each write is followed by a response and users must validate MAC to
	make sure write made it to the device.


	On the other hand, what if again you didn't get the key but you steal
	the read response?  You could replay that to the application.  To this
	end read requests include a random value and it's copied to the
	response. Application can put e.g. a counter there.



I think we are coming back full circle and I would
like to ask: so why does it not make sense to add this functionality to
a block device, or a scsi device? We'd get lots of goodies such
as multiqueue, for free.


If we implement above in a hypervisor in software, we can just ignore
all random hardware limitations, and support e.g. arbitrary size of
writes, arbitrary hash etc etc.

So I think this is the reason you are making it a separate device and
are trying to support so many messy formats is because you are thinking
about pass-through.

However, I note that neither driver nor the hypervisor really
care about things like order of fields or endian-ness.
It's only the MAC calculations that are affected.

So my suggestion is, for now just define a clean minimal interface, with
some kind of enumerator for an application to discover the specific MAC
used.  And when hypervisor is forwarding the data to the device, it can
move fields around, swap endian-ness or whatever.  Will cost some
performance but it does not look like this device is fast path anyway.

And I am guessing most people do trust the hypervisor and so they will
happily just use a clean software implementation.

> -- 
> 2.7.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

