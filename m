Return-Path: <virtio-dev-return-11547-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB79CC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:01:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 012512A821
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:01:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED17F9866F6
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:01:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF69D9866F3; Wed,  8 Mar 2023 18:01:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CBAF89866F1;
	Wed,  8 Mar 2023 18:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPeGr6EzrDZoih68jv95rv3jmGqG4y7IIrQftEtBEtNUKMMxuUTxTqYGUyobiof7rixvL2T6LAsvVivnO63V1SJvzIKFm3qQKH2TRoR8R18lUXBQRMz2h5nq7ME5eSpRcukPxWmnqGcPvCpibM8g3uh2Cz8ZO5fTlqcLoc44cSRl/pkwG+JffPZMm3MyYEH5HMtD5NHsfv/7gM3ElBHNJ9d5h2qa1BjZrnhdJQKhHzFgkW+pRcaKHkBzU5L2xoCUmIpSnjnr2d8lofjerbpJLPJ4zQPL/57N1B0cLM+c8yX3Wcru+GpUoxIxYMqQMDPVw002OHIlk05uvrAs959zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsc5IEnAhYYctgk2kUL/n6uVlRbLC6NmyBaTB/0rTlg=;
 b=U1YLVN8/ZKfaQGYI0SWz5M2salioPGsWi9diG9OjjpZYyHRkwQBCtvdWMwsOSW8AoUfpOprNuYs9vOtx3+NgQGa2ft7uxydK6NbO6uKEI7zDXuaQ7NmrwSvzc7auLBU08FSdW7nOJt0ZWifmDVEJ8dXRY/gkKrZACVvuhwnR9ec5iqKItDtLg2W5tJ+90wqARP1A9WsTw0xxDtZeMchlpQg5Fo0m7rEJloLnuImd9Bc6NdffLeEbHnnXbxSrl+OAmC4gS9mlC3qAl8lTnUZEPDOvwWA0XpzjHnBGLd784g5rfx2DpknEDKEcz1DjK17j264OmTVPUGZXpFTzw/R5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
        jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
        stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
        hang.yuan@intel.com, virtio@lists.oasis-open.org,
        Zhu Lingshan
 <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
        Shahaf Shuler
 <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
In-Reply-To: <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org>
 <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com>
Date: Wed, 08 Mar 2023 18:01:02 +0000
Message-ID: <m2wn3rxgv5.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::12) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f189f5e-1a08-4838-074f-08db1fff17c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Geoqap9t+S5AdN1tSrXT0Vko7F/wOjzMb8bKX0jwJ5tDPqiEJ2BnrMkbpL0+3eyHeKFT9qFsTCJxkAg/l5js+EaOO7Cc4I9KpHaybFvT8OkAkzPql8SLRNZSRJQTeyXvz7cdYf8nJgceYYYtLjL2yPpCSWgKONaYyO0ufaDqxxw2X8ksPO1u1zIrdlkwYdfot+4qt6rDjlzYBj/HJcJUDbNLSt1J65LJn+bYTqMEanXbCcyPomo73VyQI4IqgfHw5oRrGkARFzvYCrmM0HZtezYcIDRepfkWBA8s3yrtIYNDkfbgBfl8/NP3s8iUxmeY72rw1w7E/imm8RZfr1XNfDlG6f+c7tGGVFsCPpRxcZ/1+vzXDeSAYDyFtn43WHHp10QlzLibVPHIYeRPTcVjO7+S3GcsaZ57KIBDf0eu9G+JfREWRKBauIMp8n1q6UAGzKr0gNbabuv+ndOo3qV+8wCCS42bs01YoqOZ+PZmLmA0rL0cxDQCQy77UOkyldy+yBF1+RgLDCiJ6J18wTx9aD0mW+FTuZAZdTlROyEFwfoqWzn1D+2W2mOYICcW57BDvyhY/F1L0JcRDyF3Nxq4vY7jJ3l8O70RBWi10subm6naj/Qo4arIyMJsRRKf5SunsaDZqW1Mu5sfKfe3+8alrw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(36756003)(83380400001)(6666004)(6512007)(53546011)(186003)(26005)(6506007)(2616005)(6486002)(66556008)(66946007)(8676002)(86362001)(4326008)(66476007)(2906002)(8936002)(41300700001)(7416002)(5660300002)(44832011)(38100700002)(110136005)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?he/TC7poDXUOhLRnDwHDxxfImjHW5xhjq7FoSBRmJ1AGTnXjxOB4ckxWGZLJ?=
 =?us-ascii?Q?B44oNVcE9ZQZGR7leUSMNtZxS+VRC70YfW10iwDacVWXJHCN0x8Iz6EpYu3Y?=
 =?us-ascii?Q?7JP7YnPRnH3R7R2rTPvXO/UW5gPpISKpAiiwU5GkuXhURQ+zrtE/afMSbZZx?=
 =?us-ascii?Q?W+1duW2uIBEWaOse4uqMiZcUP6rO2WCFLu+Z+MDZgrxG/HllsB+1vgXmnJOz?=
 =?us-ascii?Q?bXWYtwUVI8PZbATVbIbQYcIG24sdJ2red4IL15h19MaXS074317gBxtQEjSW?=
 =?us-ascii?Q?zRLsr48vNxatvc9kj9h3uc22IoIi/o9mXI9XHstEigb8Xw7W9a0RNKTYyiNT?=
 =?us-ascii?Q?PXcs0PQOwjBvpvtVX1WCyhjMapzusVY7QLaagZt8eh7lMAmI45pbTM4qA6br?=
 =?us-ascii?Q?FW7rhsGfx8CZaSUJoL6ng2/kuyRfGRlDEm/OIjagUll1CEnu0ghK6WGLFMB1?=
 =?us-ascii?Q?HSVx+g+kWWykoxU7h1kRMxaL9hiN6J3dKE7+V6km0qZ6TnIdNVckjebnE1Fe?=
 =?us-ascii?Q?GUYUn0lYfAkMLcLEZZcAspcENeM8gH5XRHJZLHv3OLLhsNtSJXK+beEZC2Mn?=
 =?us-ascii?Q?WlW5oFT9ijzL62xu5gXY/9LDyNoBZI0FIduhgE9zj6MKvi6Lhipql/dYjT8f?=
 =?us-ascii?Q?YAP9a+HK5DmOEmqfo1gH3HPvXgtnQlFU+Vj+JJnNnzeogRpIDAmP8KwIzh54?=
 =?us-ascii?Q?lplTpFgPbojPYyP058y/c06H7lu37oZPPhnD77nCqIS1k+29/WojgPlRfI2n?=
 =?us-ascii?Q?2qiDwDFayrL7saZ7yAab3kdoWJ3L98FAUIaDb9yA5ZYB2hqlOIymgL8T3t8+?=
 =?us-ascii?Q?vl7/CyHBbX1gqozbIN8vExdjNTe26RoJNbLzv7zBtVLakQnvgQt4uo4D/8aG?=
 =?us-ascii?Q?Ab0ikccstra1Fzn6M5ikt68OamEs2Ac/cgURPVDyUZmwjBQLNkJH4BMkQv2j?=
 =?us-ascii?Q?sojkGqbUD3/s2CHScrAbS7SYoIgnbSmnBk1lIG57gvs+5YL2NVxnXCMmmNBe?=
 =?us-ascii?Q?krATp11ObkTxOvuEf98q7Kjg5t9gMKZOl3ZkDwRloHrD1n46Ulrh8mAfZhWM?=
 =?us-ascii?Q?sSBHaqeUc3uUn/L1gbtxfg4ko5q56qVNi5XgLjZLSvUNyFwsnzpvnL68tycw?=
 =?us-ascii?Q?1IpnsTlF9YCWU+bjjVsExAPfteCsfZh5CZfILgsrkgXNXg62Eaz/OZtulH/V?=
 =?us-ascii?Q?VoeJ4tf8G3757rfJA/VUchu5bKpOW/ITmkkOwV9HUuTF4gzEiGvtT9sX+C99?=
 =?us-ascii?Q?KLIe3qsMhqRPgAKydeaZWt3L2xMwkzkCe+xHzI5woAruJ5ZQ1bv8bvxMCo2a?=
 =?us-ascii?Q?psXCez4nl9QT28aR5J3wFqPN10Ot24P0bE54XQVycIA1oI1qfJT8UlUaMgtY?=
 =?us-ascii?Q?zKwJTHkeSuY8B5LDOupi29dfdicwH7zEBoicEMwHbnbQ9KACjQ4UHCC1HxLT?=
 =?us-ascii?Q?tl7rCIGW6580Gd4PEnqbRu6TbgnoB+xYYlQZjTgzZuYDtTfC+rpyfnWVMchm?=
 =?us-ascii?Q?u5SNMwW4ZIVfHSsr+1VGdmFfDEaYOfnsygBKLSEfxrTKCcVw1AJ841YykELc?=
 =?us-ascii?Q?R3tS0GTmbkzGFm1nhickSSQKwUggNbQFKl/rcDvLV2rci56v68yW+0a9Ybq6?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZRof6OwHXVoTekEgPsC6E6nFCsqGbDffUDZAR5FX5rQcEc4ALEtIsMrvCudWq6J0rtbTnXwlBlyA7OXAgAv8UlXIOQAuTWMBAD3seB30O1p86w+jk2UwopVgog4gMqPp9og08Qp7QwPVAiUxLMjcUYyq7I2mflbfdw0MspjK20s6lG8TBl/eswYZjvhvie57bIVQfsn6uZXrAv5GP8UPh3xFdYIsmUkkV91sjq9f9gNfo+hcxdIC0eEQRWASb//vy9MKQmvSdT+jFa0YEtdJ6dUAw71GtNW6yTxdMqYUFs8nqTEbwWCRAwq2O5hWwq3AQcDlTrf+O6ScRFo+OEXbzbuD1a3NJBed9ojrqe361xhLQsqkK5gpigQS2qKlPMNV5hlhvjtqcqAF8/KxzPQ+UVop7/kcwPvu0EX69UWuu3JR/hswwVZPt99YphuJnrCfRoetQyUHRLNsVr/w1Lx7MZGbaaxlNLf/inB4HmM53KAEsruQlCJSbB26kf03m7D5CoX+GisfLhZQo8osjl9gZn4+2DTaegnyPTjeQDzBuGRZg8QnINipEv1MU0ygwWGMTbALV2XNHKpP2IJl413wEnAWU9bu/4FyB4e+6O+0stnOCdpC4AeYgMpsMMF6aPdXkrZEmeaJVxF0xOUxJAupbLmQ3DZ/rOPnMYKFxwGhd8rvWPaO6MOIYXiQc6FbQn6qXLzICbJYc3I7clML+hLzFex0bkOv135H8GKsQ1YEL8Gee5vN9pvuIL7ffVLtD+bX6G3G+AoGuCrPbJy/q9vv1H9gBTzZvdZQE1GNsZlllTi6eSw95bCbnl0UJxc/CJ1IsaLgyla9/Ny/yHXDqG+EoI03JBOgy/hN/JM4N39IPvNabcjbeQ7+OSPfB+QfX4zpENrQ/VIMCGDQmbdnE4x4QQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f189f5e-1a08-4838-074f-08db1fff17c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:01:08.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6KejEP2X43gzSgAq1pIpXzys2zzz79rBpqSDFCYfpOOQhGCI4gLLvnBgmbhlFk6peQJT3MpYLSV8IkTEkzMW+3Yp2WVIKZsu0v1/U9IWX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080153
X-Proofpoint-GUID: EV2kF5B0vhwsCvk674nHD0uk1TFM3Da3
X-Proofpoint-ORIG-GUID: EV2kF5B0vhwsCvk674nHD0uk1TFM3Da3
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

Max Gurtovoy <mgurtovoy@nvidia.com> writes:

> On 08/03/2023 14:08, Jiri Pirko wrote:
>> Wed, Mar 08, 2023 at 12:50:48PM CET, mst@redhat.com wrote:
>>> On Wed, Mar 08, 2023 at 11:05:00AM +0100, Jiri Pirko wrote:
>>>> Tue, Mar 07, 2023 at 05:30:18PM CET, mst@redhat.com wrote:
>>>>> On Tue, Mar 07, 2023 at 08:36:41AM +0100, Jiri Pirko wrote:
>>>>>> Hmm, if not for now, the future exension would not be so simple, I fear.
>>>>>
>>>>> Without knowing what it is I can't say.
>>>>
>>>> Yep, so basically you say, for other things if they appear,
>>>> let's introduce another queue type? If yes, sounds fair to me.
>>>
>>> Yes. For example I find it likely that live migration/failover support
>>> will require a queue where driver pre-adds buffers and then device
>>> supplies information as state changes.
>> 
>> I see. So there would be a queue called for example "child state virtqueue"
>> or something like that for the sole purpose of getting the state of VF?
>> Hmm, wouldn't it make more sense to have this done as a part of "group
>> administrarion queue"? I mean, there is already notion of addresing
>> child/VF here. So from my perspective, it is just another "group
>> administration" command.
>
> For sure VF Live Migration, MSIX config of VF, VF feature bits config 
> and others should be admin commands on admin vq.
> I don't see any reason introducing another type of admin-like vq.
> Also we don't need to have multiple admin vqs. This AQ is not aimed for 
> performance.

In support of live migration, might we end up moving large amounts of
device state through the admin queue?

If so, that would seem to have some performance requirements, though I
don't know if it would justify multiple admin queues.
-- 
Tonight I think I'll walk alone, I'll find my soul as I go home.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

