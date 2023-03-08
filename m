Return-Path: <virtio-dev-return-11549-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCC8C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:20:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C4F1B2A880
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:20:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45E8A9867E8
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:20:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B7CD49866F2; Wed,  8 Mar 2023 18:20:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18FD69866F1;
	Wed,  8 Mar 2023 18:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsGKnBt+bg0k9G2v0CWzE9wPDcjaEhz1l+D/4j1D4NeK+OEZeH0XE2RW+KXJ/IWoqSfg3gf1wOiKl+0g/XKJ+l7mOccFE6WcuoWnC9S919cC+u4ffyCAfWoQvb+NKcbjg9AmZ36Cu5JcpoDIwRKNOKTPYCfZ8R2UFTCKDDIdTpgTHAqhuObwWT6/BQpfWhqO8DDsOGzNiyjPM4TjwjKm9ujQFiJxwC1Cyax9BKh8J/OMDeTEZn5lylrRuDgCAj/BLi+BpXpOJmDEKxFTJY9k1jG96JoFTU1xcpmmPaF+yShAXeAoCCNg/HLsOcujcZFsW4UpJ5x/a2YDnt9Ja9TNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy83BLuol4h3dv6NpIWayQpgk8WkJixoZPCRLCci8l0=;
 b=SdAW0cOkaCAkK8Cklwvi+BMeWv9WkQ6qN5jM8pc+qIGAhTO2HYFplwrkOvUz/NnH6oIiayx3wO+eeG7ioGJxT7WkUw6oNKmifZ7DTrorzD+mFwt7AbmILg/KBrT7s8lCpxZFIeP+7vbj4yLqd5hpa4fF+7nErjxgFqLXXksips44imlJSy+yxB0NL+liAG08kPp5WpAwXJOm2ZAxcxm/Lo3AfHDEqbjmmlhuQkde0viIbVxXfdsjyFjRoQHNbLhO3qnVF/FIsfblB72ynwyjbvH/cK0e6WA3jpZRxeWIjWe7B8N0wd4C/p4OqM5yDGDzQ3C/M9fChG2/KykBreRRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 19:19:32 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <ZAjRtEooD8OK70Pq@nanopsycho>
References: <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org>
 <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com>
 <m2wn3rxgv5.fsf@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wn3rxgv5.fsf@oracle.com>
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cdcbb9-8e25-4899-89bd-08db2001ac49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xid28aFmvXjAB82xxIj6i99kCX0wIPyDAM2XlyMa4Sf/OdIkXtYrgEz7iXNDgpH1vRneDOQM2zFo2tdQFiiyaFTbZUkg3Kc5rmgKF3dmOa5KeV/oWbknmf3fYqwvluMgRItk/84FkEmsIu8CSZxk0ZVN6xHfiEe5mb4XzZMaD1Ta7iRRqy72SUjW0PLdPLwihE1J2UJkfMfvOTnfw/n0gBqDQk/JDQK7VR96wh/VXFxtgW4NWYlb/B0IBS8f07bM13TsGrFFueQDfz+Lz3QECMLskWXo/c6Sc9SAGmBuzl4lBCHJDMq8k4gW9AiyhTHGmoiPTURx12jJJvVbGQbiVJ/BI/T2mKys4CRddJUbK6li7wmgkTHfYAm8lv9p4R6kg6OLk66jKvyNAP/wVzL5IiM/Z1QbVbADQPSG2er2khfbUZtKmuCSBGBTWx80ctGZtZm3H3gLchSBXVSzj9QT/ugx9qq1YxwXgIDMBCXZMKK0lUX2mt2Pif5VC8dHZ4KmPM73zo9v4jTt9VAxsCfKZzvV7fZHiOCA5Kk2EqSmwcWXSHh6h6S8kgNeRHvehtYiRqR5P+sv6kCTphd3xGl8sztwdV4paK9aZ3xYZ5ymwtHPTblkVWbrYvFdga3QC5HxDRNpYsfyXWsYjIVwjsc/WQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199018)(107886003)(26005)(83380400001)(9686003)(6486002)(53546011)(186003)(41300700001)(5660300002)(6512007)(6666004)(8936002)(7416002)(66946007)(66556008)(4326008)(2906002)(8676002)(86362001)(6916009)(66476007)(316002)(54906003)(6506007)(478600001)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oexwq+1xoWrOObHdxX2OxZA09Dtdni+gYV/w64v62xxrMkWz5cXulaTTYSEw?=
 =?us-ascii?Q?jz2O33ZNSItEkOP1Y6kU3qZpnlA530Klr7kX400Sd2PNzC8LD7feI0YCMVNx?=
 =?us-ascii?Q?oSEXPuvRnfRPWpa4wXwOU258ZH0ou9tGvYw7eHLg+If4DECPGgo1bqmCSTcT?=
 =?us-ascii?Q?0FtazwdaJlLMO73DvyKK44gN7hFGFSqf9s4T6KcN2mluflKtdUIuhHFQDz04?=
 =?us-ascii?Q?9jmKLpFwGn3PuXjeTiXYfnpmqNEYlvYt7Wfi2LWWQT3gdT7m8mPHmhctkKPD?=
 =?us-ascii?Q?BL1qXhlGJbzglNWPEl6EUyQUSXZ4DYk49o7rVmYTclSH1iV+jBPdiwf/8VpB?=
 =?us-ascii?Q?2HnTOFRj9MX/uy1p55kpFuR5+5XvXpich40IkMvl3yMIcb0IFDgCMsF3sGg1?=
 =?us-ascii?Q?8bMF1vDKbvRzL8YiDNm05K6FmDt65TXnDkhTzN1NVDGQwWhkE1C9VklLws22?=
 =?us-ascii?Q?AmOroTvFNPY5p+WF3ov5UZ7MXT++tFGA7qXMyoxqetsqibvRBywCDNZy1EP2?=
 =?us-ascii?Q?Rl+jjmeWC90PFiwZSLEZcH7RQTQHigO1cauFXa1aoT6U7ibVMrUvV2XIrahr?=
 =?us-ascii?Q?3WFCz1kviIC+tebFN1j0PGHQHYd5c2956jPnco3iYxvY2Zw2r69g3rdvMo58?=
 =?us-ascii?Q?pMhTL6LijSeIo6rKSioxQkOgePi/nqvRirWfAqiSVKhbV/dyiMiUukmv7ynP?=
 =?us-ascii?Q?mRHNPkiPfP38FtQ+PV4Mwl+RK/6O2kgDr+U2hVeVdXLDu4xioy2XfOQEnpk5?=
 =?us-ascii?Q?b9O/b+PZpITQ9sjoYSuF4l0z5sRt6GC+cmqnG7KY++5W7yFV5TRb9SPA329l?=
 =?us-ascii?Q?0VleM1P93lRpcSSQawFY6kv19RobJo0x/CquebidrA2bXVhtFibRnpSVCaIU?=
 =?us-ascii?Q?HP26q7NFTAQzULXVokgtlsiUBSZXG8IDdK/Mtw/E1/UWfEqPIMLnVflBRbMU?=
 =?us-ascii?Q?P7SRGS6vhXx0YQVzRpO8hcr50eLsthjuOG4deHdmseJbG8M0dmMkqYMBO8jx?=
 =?us-ascii?Q?KpRhy5l9W7AgEqfSSbFCI8cWAKCcWfFCWVnMuj/SrJr5ieLiy/LCv5RtOpdu?=
 =?us-ascii?Q?U6phpsagCzInl5qZtv851W2TLSNLwxd1vTxS326Lcloc8O+ycovR8wgCYNdY?=
 =?us-ascii?Q?odyJFa4hoqVzZ3FLNi39y4OkZFpL1qBOn9LNJayBG/w0Po+dfGMUdNvoQ6Hj?=
 =?us-ascii?Q?dmIqer56V7oOHajG5rZ21Y01OWA0LGnwI8MjecgNn3qmE0nEMUJzL1nlN8hd?=
 =?us-ascii?Q?3/YVaNQeWZ5wJvdguGnrUAZB0lhMBUN3Kg3zteUafoY0QYVA7sgFsrfPgbtV?=
 =?us-ascii?Q?bg6dfdIEphsNPoDbCC/ZNS+TJoxoVuTae+25pw4pIVYH9iRFbv9W8KB1tltJ?=
 =?us-ascii?Q?o0MAEDjUeXflLTn7UdIG4On8PtZzOadh4UBdLm+el5MTqHgPBOfRKU9rSQSN?=
 =?us-ascii?Q?4EUh/2DISgDaHBtFZuQJ8vWMHbVIVu0cuGJ/jt+O6UKo2qLgtdkG+K2feS8p?=
 =?us-ascii?Q?djlShvumgNArSqHBlBaz/vqWxVat4a3sYQXrKIqdOQ+NSLrDOZIMkDfm+aeY?=
 =?us-ascii?Q?SNLiwRbxsCP7aWx6npcp2ba7Myoq1TxUw3X48kHa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cdcbb9-8e25-4899-89bd-08db2001ac49
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:19:36.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cUBWd5LMylC2l/GkjZwBYirVbHrpC/QSOV02Fr0jXuUE/QgDgPuGbTbTgNMn+9A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

Wed, Mar 08, 2023 at 07:01:02PM CET, david.edmondson@oracle.com wrote:
>Max Gurtovoy <mgurtovoy@nvidia.com> writes:
>
>> On 08/03/2023 14:08, Jiri Pirko wrote:
>>> Wed, Mar 08, 2023 at 12:50:48PM CET, mst@redhat.com wrote:
>>>> On Wed, Mar 08, 2023 at 11:05:00AM +0100, Jiri Pirko wrote:
>>>>> Tue, Mar 07, 2023 at 05:30:18PM CET, mst@redhat.com wrote:
>>>>>> On Tue, Mar 07, 2023 at 08:36:41AM +0100, Jiri Pirko wrote:
>>>>>>> Hmm, if not for now, the future exension would not be so simple, I fear.
>>>>>>
>>>>>> Without knowing what it is I can't say.
>>>>>
>>>>> Yep, so basically you say, for other things if they appear,
>>>>> let's introduce another queue type? If yes, sounds fair to me.
>>>>
>>>> Yes. For example I find it likely that live migration/failover support
>>>> will require a queue where driver pre-adds buffers and then device
>>>> supplies information as state changes.
>>> 
>>> I see. So there would be a queue called for example "child state virtqueue"
>>> or something like that for the sole purpose of getting the state of VF?
>>> Hmm, wouldn't it make more sense to have this done as a part of "group
>>> administrarion queue"? I mean, there is already notion of addresing
>>> child/VF here. So from my perspective, it is just another "group
>>> administration" command.
>>
>> For sure VF Live Migration, MSIX config of VF, VF feature bits config 
>> and others should be admin commands on admin vq.
>> I don't see any reason introducing another type of admin-like vq.
>> Also we don't need to have multiple admin vqs. This AQ is not aimed for 
>> performance.
>
>In support of live migration, might we end up moving large amounts of
>device state through the admin queue?

Sounds to me that would be the case, yes. Depends on device
implementation, but could be potentially big. We should make sure it
scales good.


>
>If so, that would seem to have some performance requirements, though I
>don't know if it would justify multiple admin queues.

Well, I can imagine when migrating a lots of VFs at the same time (host
shutdown), multiqueue might definitelly help.



>-- 
>Tonight I think I'll walk alone, I'll find my soul as I go home.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

