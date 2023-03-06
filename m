Return-Path: <virtio-dev-return-11451-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10614C64EC4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:40:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 70D7E68472
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:40:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C1E99866DA
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:40:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 51DDE9866BA; Mon,  6 Mar 2023 16:40:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E71E9866B9;
	Mon,  6 Mar 2023 16:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ahdf8jxiRc9I55TUpTvSlodlfnKVlN30Rcz9VbfNzigygBxvzxxiFKO78VDkhO/1Mqx4T2sjzj8Or9VJa1ROigEJ2zQvLvR/MYsmTHrfVQo/dK1h3q2vAQE3MSdc9ckvqP9cpfGiTWj9quCs390tT7HlfNeCDzSryWHWBYBU8y77v62nSMj+BubkMW7lGlH+ImAclUE7hIajTpm6WmT+QmmNH/IMlajjs/jXBoaB3+1oR1EFGAq8pCFflsJQVLkU343kq6qsLy7tpbGrYgxNDdb0zeABa12mv1tsRPNPIpdSMboLAsJ5WwLd1oxOYZUZ/QMVqetjzgGe9O0gdImM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfpyZEayv1wopTYB/gQ0lk/aWCPPs5XrgLtU/4kXrew=;
 b=gPcWolqHPaqsWOx6VRAJNBbogOjZc33WLwb10G/itEerjsDHBCNcVk3eu4t2J+QWQsLs6Qfi7Ruor2+9c8AEJd6i6zOuCGqUuU2n/UH+zTWkNl7KI/T1aeE3JF/1s5Gwjw9/Q/exBjB+zN22g1T29G4IMxo8BrmwSRtt0zbTeocF5qwunhOQuy+UeixPMxsCzVxEkzo1GNHhI2fMf9rNSLqApjttYbeGM0Dmh38+lgYEKrOY2fmJtM8Dfa7Mgx0OBMMenF+0NGPbKJai3Bg6MfXWr9W8ZGx0sm9mhGamGJ43iYhkuXD78FtdrP+a4npVvCFqnqK5WkNGp1ZwL25Ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Mon, 6 Mar 2023 17:40:04 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAYXZPVulKWDIuRr@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0bb4b3-9df9-446e-febe-08db1e617357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K6ROxpB9dnpP4wCjkKROcErjqPmHaaqyzVBDKtKEVeN7U6ilahIw71TxOpiOtZ0qnGHWwmrn+JPRvbiVrapO3qpl+O0AZ5BC45RGBH5/dhIqc+64iqbA0Ymu5nzrrYQtcJIIlZXjUpMyyAk8S0mfkxWuF53jc+mCQ6wC/rQw2f2SmYNdnvM+ClTUony47e/OxibXYVtvFT2H+aWfBZiolepu67CViwQh3jkvOQ9HeLzMLS6p7lZhL1iC+yyE3eMQ87dWk6VeECWiXi7S3MTGNvZWzwCWm60QUZ0fzEWbzDAKIP5koEwznlBGq2+V9h8bA6PHlnnaMZ5+mLOpeSJemIMH7R66BbRcQu8+eECfWjYhO5OcHajUvodu4lwGNyalvqJn2G77qgsbPCYuWyBdinPOLvzPoS9LQN4Gdq0NWUczYvpCFtKyC/9ApUJ/2fzPk6St1cQdVzGl/3K7yhESwrtiFl4QJPdk5OBMupAoTIkkrhN7cRZfE4x/0xwEazx/ciF+u/VIVkdoVBvSAs2ox9fwuS55oTabocCvVuDhgw3+TiG0ZnTzsWPMZAwANxFakYcP78marUydA6Sz9koazPye/pwF2y1u8TG9CBryPWOhH9Tte6PrakOKHDAqVsA5I9LmZYTsaFCYfrC1Gbl0Vg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199018)(8936002)(7416002)(5660300002)(41300700001)(4326008)(6916009)(8676002)(66946007)(66476007)(66556008)(4744005)(2906002)(6506007)(316002)(83380400001)(54906003)(26005)(478600001)(6512007)(6486002)(107886003)(186003)(6666004)(9686003)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3E9NCd8dYNjAPRKUCm5b2BCiUHHXKUNhRIgel/2TxPZqjjYfLMF5oMcWGe3n?=
 =?us-ascii?Q?DBwPvrgD7me+pxORXTGX4veLLiXKV0KQKbnO4x/7CKaJQTK+fqQmUVFfdlkQ?=
 =?us-ascii?Q?17KMJkEWdvqntFiFFz+DeEiq3SIPonDODrZgrppC+m5QVcO6iCY3nG4YiZVk?=
 =?us-ascii?Q?hC/ypb3spCwzx7KbKYJZDUAkn3TB0iBdm1Mup/OGI5BIiFbVNbhDQ2qfO7h7?=
 =?us-ascii?Q?rkQvz7qTl3f6Msu5gz3hqdtWEGo5ibQ1Sjjj+q0YVkenIuAlLVk6f3biMI5z?=
 =?us-ascii?Q?+cVAvIoSOIdU7yQ+NpkzxJdnmbuDZ/rurQoiHNZRlKeeyZe41FQ0zQ6gi1bj?=
 =?us-ascii?Q?ZuvYKw3X98+FjybET45r6IGdMFQMs49/kVyl1zH+LRojgLZNgIxOz3ylbFWx?=
 =?us-ascii?Q?02B+Eg5FGkVkTTUwSd1WbBEsnQqz4dh9TpRKu6m4K+s/rhoXM21oXbPwMqcV?=
 =?us-ascii?Q?zW+OnKDaeOFPKbrhT8y3PQuwMGL5/vHPON4t92sBKms1N4jIdhlh9TXBaR8U?=
 =?us-ascii?Q?R5a/BSmo2/E8HBDZ2lJVhryKQLaYObVcXfEbTCBxmnryFHBDVMy+n+Kg7dLT?=
 =?us-ascii?Q?GSyl6F2AUlurhMSNooGYhkJavThajJajKLV5lwrimK+uja7Z62cI/AS+rnNT?=
 =?us-ascii?Q?WXdAaylhNrxmpkFLCYy/7nsBKvnbmE4iswvXNDZxsamqiVtrh3kBh76IiKHN?=
 =?us-ascii?Q?zri9duwSNNfyy9GTunttu3yWaDlEwCujnxGSvGhlLxWw8jbNth6oetT6ZCYB?=
 =?us-ascii?Q?nfhK22lzg0/AP9B66dRCOttVS7dGadrXw2EEx1OtIDa0+EiOXbHMjAKZDXx1?=
 =?us-ascii?Q?sU2WyCbQ6q/LgEcyAWojD2A+4ZUSFWnQQOthYjKoH+tjGz45ezdGpSNUtuex?=
 =?us-ascii?Q?Zn9343HWKNaKFtNZQ5ylpTIMJ3jWwZQ/U8EiI+ZJJxumV8441AcFy+PwLnHB?=
 =?us-ascii?Q?4G2/oG8AKbZ1hlqMjWRaebmFELMzi+R9Zw67MMMK2e3AtvMNZ/f1X0Dc8dj3?=
 =?us-ascii?Q?SqrUcVlwcsu7pk+K2bhQ5LCBkIEP/vKhYJbJ1lEQ8B30QjluVf6s0p6mabrF?=
 =?us-ascii?Q?GVNT7UcMX0aq06Dbhk7rWX5DBQi6u3OxZq/SmMsPQzqDsNIQGbgXGKadMB1o?=
 =?us-ascii?Q?N34YtZwVUHhuPKbyoqVX8zkWptWCjsIgAshgqw1z5AUBsB++5Y35F91WPz2g?=
 =?us-ascii?Q?5ZpOTh5cWeeMC68kyqO6sDUclo1bcp+cAePJFYAP+tIBB5qi0TvAPfi1vcAp?=
 =?us-ascii?Q?HYz+97xIOBgOV1KdVtXBU+7+NCsMBR/W6z/mccJDOEB/YUJylT12Y+DVItPK?=
 =?us-ascii?Q?NfgdhRg94igCmZX9E0iohWycWkYSFyfA15xRQYCncvtsSuLbBd1dzDYagpr3?=
 =?us-ascii?Q?3dZCd3DI0u/onM0DAIO6tCRnFRxp9b20PpjEFM6gviaj9Hp+dotgcOASEDwW?=
 =?us-ascii?Q?7EJOk++RR6TJX7Y21asphhSKbopFNRJZD4Rw2sbxRxvaAMuEdFL80RqZpejk?=
 =?us-ascii?Q?nurAb9aExrt707Kud971Euflbuap0wj4OKzYQiyW7dfOrJYdZMRFRfdIPTTl?=
 =?us-ascii?Q?IeETDqEzs81U02GMP8bqfmBY5rQHsEsiCJUQxmNe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0bb4b3-9df9-446e-febe-08db1e617357
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:40:10.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN2TG17s7WTVO2A0nonc+HuU2Soo/j1ECB3B6qBHvhATgq9oLKI1aZLoNZVnWGGj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:

[...]


>  admin: introduce device group and related concepts
>  admin: introduce group administration commands
>  admin: introduce virtio admin virtqueues

The ordering seems a bit odd to me. I think that at the beginning, the
admin virtqueue should be introduced with generic concepts (including
the generic command structure), only after that the section introducing
device group stuff and related commands.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

